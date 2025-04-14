//
//  HotelSearchViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

class HotelSearchViewModel { // MainViewModel
    
    static let shared = HotelSearchViewModel()
    
    var hotels: [Hotel_List]? = []
    var sortType: SortType = .defaultSort
    var dataIsChange: (() -> Void)?
    var sortTypeIsChange: ((SortType) -> Void)?
    var isTrainhadTap: (() -> Void)?
    var isUseFilter: Bool = false
    var isTrainSelected: Bool = false
    var isUseSort: Bool = false
    
    var sortedOverlay: SortMenuView?
    
    private let filterViewModel: FilterViewModel = .shared
    private let manager: HotelAPIManager = .shared
    
    init() {
        defaultHotel() // 預設飯店
        manager.hotelsDidChange = { [weak self] data in
            self?.hotels = data
            print("一共 \(data.count) 筆資料")
            self?.dataIsChange?() // 給 ViewController
        }
    }
    
    func defaultHotel() {
        hotels = manager.hotels
        print("一共 \(hotels?.count ?? 0) 筆資料")
    }
    
    func fetchHotels() -> [Hotel_List] {
        guard let data = manager.hotels else { return [] }
//        print("一共 \(hotels?.count ?? 0) 筆資料")
        return data
    }
    
    func hotelsCondition() {
        defaultHotel()
        if isUseFilter {
            hotelsFilter(min: 1, max: 1)
        } else if isTrainSelected {
            searchTrain()
        } else if isUseSort {
            hotelsSort()
        }
        print("一共 \(hotels?.count ?? 0) 筆資料")
        self.dataIsChange?()
    }
    
    func hotelsSort() {
        switch sortType {
        case .lowPriceFirst:
            hotels = hotels?.sorted { $0.TWD_RetailPrice_Value < $1.TWD_RetailPrice_Value }
            self.dataIsChange?()
        case .highPriceFirst:
            hotels = hotels?.sorted { $0.TWD_RetailPrice_Value > $1.TWD_RetailPrice_Value }
            self.dataIsChange?()
        case .defaultSort:
//            defaultHotel()
//            self.dataIsChange?()
            ()
        }
    }
    
    func clearAllFilter() {
        defaultHotel()
    }
    
    func filterTrain(){
        if isTrainSelected {
            manager.searchTrain()
        } else {
            defaultHotel()
            self.dataIsChange?()
        }
    }
}

extension HotelSearchViewModel {
    
    enum SortType {
        case lowPriceFirst
        case highPriceFirst
        case defaultSort
    }
    
    private func hotelsFilter(min:Int, max:Int) {
        let data = hotels?.filter { $0.TWD_RetailPrice_Value >= min && $0.TWD_RetailPrice_Value <= max }
        print("搜尋區間為 \(min) - \(max) ")
        hotels = data
//        hotelsDidChange?(data)
    }
    
    private func searchTrain() {
        let data = hotels?.filter { $0.Add_On?.count == 1 }
        print("搜尋適用加購高鐵為 \(data?.count ?? 0)")
        hotels = data
//        hotelsDidChange?(data)
    }
}
