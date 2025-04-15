//
//  HotelSearchViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

class HotelSearchViewModel { 
    
    static let shared = HotelSearchViewModel()
    
    var hotels: [Hotel_List]? = []
    var lowestPrice: Int?
    var highestPrice: Int?
    var sortType: SortType = .defaultSort
    var sortTypeIsChange: ((SortType) -> Void)?
    var dataIsChange: (() -> Void)?
    var isTrainhadTap: ((Bool) -> Void)? // 給 filterView 通知需要更新
    var isUseFilter: Bool = false
    var isTrainSelected: Bool = false
    var sortedOverlay: SortMenuView?

    private let manager: HotelAPIManager = .shared
    
    init() {
        defaultHotel() // 預設資料
        print("一共 \(hotels?.count ?? 0) 筆資料")
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
        manager.hotelsDidChange = { [weak self] data in
            self?.hotels = data
            self?.dataIsChange?()
        }
    }
    
    func defaultHotel() {
        hotels = manager.hotels
    }
    
    func fetchHotels() -> [Hotel_List] {
        guard let data = manager.hotels else { return [] }
        return data
    }
    
    func hotelsCondition() {
        defaultHotel() // 從預設開始篩選
        
        if isUseFilter {
            hotelsFilter(min: lowestPrice ?? 0, max: highestPrice ?? 0)
        }
        
        if isTrainSelected {
            searchTrain()
        }
        
        if sortType == .lowPriceFirst {
            hotelsSort()
        } else if sortType == .highPriceFirst {
            hotelsSort()
        }
        
        print("一共 \(hotels?.count ?? 0) 筆資料")
        self.dataIsChange?() // 通知改變
    }
    
    func hotelsSort() {
        switch sortType {
        case .lowPriceFirst:
            hotels = hotels?.sorted { $0.TWD_RetailPrice_Value < $1.TWD_RetailPrice_Value }
        case .highPriceFirst:
            hotels = hotels?.sorted { $0.TWD_RetailPrice_Value > $1.TWD_RetailPrice_Value }
        case .defaultSort:
            ()
        }
    }
    
    func defaultLowestPrice() -> Int? {
        return manager.lowestPrice
    }
    
    func defaultHighestPrice() -> Int? {
        return manager.highestPrice
    }
    
    func defaultTrainSelected () -> Bool {
        return isTrainSelected
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
    }
    
    private func searchTrain() {
        let data = hotels?.filter { $0.Add_On?.count == 1 }
        print("搜尋適用加購高鐵為 \(data?.count ?? 0)")
        hotels = data
    }
}
