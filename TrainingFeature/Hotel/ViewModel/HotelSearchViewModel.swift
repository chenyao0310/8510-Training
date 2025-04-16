//
//  HotelSearchViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

enum SortType {
    case lowPriceFirst
    case highPriceFirst
    case defaultSort
}

class HotelSearchViewModel { 
    
    static let shared = HotelSearchViewModel()
    
    let filterViewModel: FilterViewModel = .shared
    let trainViewModel: TrainViewModel = .shared
    let sortMenuViewModel: SortMenuViewModel = .shared
    
    var hotels: [Hotel_List]? = []
    var lowestPrice: Int?
    var highestPrice: Int?
    var sortType: SortType = .defaultSort
    var dataIsChange: (() -> Void)?
    var isUseFilter: Bool = false
    var isTrainSelected: Bool = false
    
    private let manager: HotelAPIManager = .shared
    
    init() {
        defaultHotel() // 預設資料
        print("一共 \(hotels?.count ?? 0) 筆資料")
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
        
        bindingHotelData()
        setUpFilterViewModel()
        setUpTrainViewModel()
        setUpsortMenuViewModel()
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
}

extension HotelSearchViewModel {
    
    private func bindingHotelData() {
        manager.hotelsDidChange = { [weak self] data in
            self?.hotels = data
            self?.dataIsChange?()
        }
    }
    
    private func setUpFilterViewModel() {
            
        filterViewModel.defaultInitial(defaultHighPrice: defaultHighestPrice() ?? 0,
                                       defaultLowPrice: defaultLowestPrice() ?? 0,
                                       trainSelected: self.isTrainSelected)
            
        filterViewModel.filterConfirm = {
            self.lowestPrice = self.filterViewModel.lowestPrice
            self.highestPrice = self.filterViewModel.highestPrice
            self.isUseFilter = self.filterViewModel.isUseFilter()
            // 為了讓 hotelViewModel 正確更新
            self.isTrainSelected = self.trainViewModel.isSelected
            self.filterViewModel.isRefresh = false
            self.hotelsCondition()
            }
            
        filterViewModel.filterCancel = {
            self.isUseFilter = self.filterViewModel.isUseFilter()
            self.filterViewModel.isTrainhadTap?(false)
                
                
            self.filterViewModel.lowestPrice = self.filterViewModel.defaultLowestPrice
            self.filterViewModel.highestPrice = self.filterViewModel.defaultHighestPrice
            self.filterViewModel.isRefresh = true
                
            self.isUseFilter = self.filterViewModel.isUseFilter()
        }
            
        filterViewModel.setUpDefaultFilter = {
            self.filterViewModel.highestPosition = nil
            self.filterViewModel.LowestPosition = nil
                
            self.filterViewModel.lowestPrice = self.defaultLowestPrice()
            self.filterViewModel.highestPrice = self.defaultHighestPrice()
                
            self.isTrainSelected = false
            self.filterViewModel.isTrainhadTap?(false)
        }
        
        filterViewModel.isTrainhadTap = { [weak self] bool in
            self?.trainViewModel.isSelected = bool
            self?.trainViewModel.isSelectedDidChange?()
        }
            
        filterViewModel.setUpReturnToDefault = {
            self.isTrainSelected = self.defaultTrainSelected()
            self.filterViewModel.isTrainhadTap?(self.defaultTrainSelected())
        }
            
        filterViewModel.lowestDidChange = {
            return self.defaultLowestPrice() != self.lowestPrice
        }
            
        filterViewModel.highestDidChange = {
            return self.defaultHighestPrice() != self.highestPrice
        }
            
        filterViewModel.getDefaultPriceRange = {
            return (self.defaultLowestPrice() ?? 0, self.defaultHighestPrice() ?? 0)
        }
    }
    
    private func setUpTrainViewModel() {
        trainViewModel.isSelected = self.isTrainSelected
        
        trainViewModel.trainSelectedDidChange = { [weak self] bool in
            self?.isTrainSelected = bool
            self?.hotelsCondition()
        }
    }
    
    private func setUpsortMenuViewModel() {
        sortMenuViewModel.sortType = self.sortType
        
        sortMenuViewModel.sendSrotType = { [weak self] type in
            self?.sortType = type
            self?.hotelsCondition()
        }
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
    
    private func defaultLowestPrice() -> Int? {
        return manager.lowestPrice
    }
    
    private func defaultHighestPrice() -> Int? {
        return manager.highestPrice
    }
    
    private func defaultTrainSelected () -> Bool {
        return isTrainSelected
    }
}
