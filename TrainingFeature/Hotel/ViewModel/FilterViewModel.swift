//
//  FilterViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/9.
//

import Foundation

class FilterViewModel { // SubViewModel
    
    static let shared = FilterViewModel()
    
    private let hotelViewModel: HotelSearchViewModel = .shared
    
    var defaultHighestPosition: CGFloat?
    var defaultLowestPosition: CGFloat?
    var defaultLowestPrice: Int?
    var defaultHighestPrice: Int?
    var defaultTrainisSelected: Bool

    var lowestPrice: Int?
    var highestPrice: Int?
    var isRefresh: Bool = false
    
    var lowestPriceDidChange: ((Int) -> Void)?
    var highestPriceDidChange: ((Int) -> Void)?
    
    var highestPosition: CGFloat?
    var LowestPosition: CGFloat?
    
    var confirmDidTap: (() -> Void)?
    
    private let manager: HotelAPIManager = .shared
    
    init() {
        defaultHighestPosition = 0
        defaultLowestPosition = 0
        defaultLowestPrice = manager.lowestPrice
        defaultHighestPrice = manager.highestPrice
        
        defaultTrainisSelected = hotelViewModel.isTrainSelected
        print("de   \(defaultTrainisSelected)")
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
    }
 
    func confirm() {
        confirmDidTap?() // 按鈕確認
        hotelViewModel.lowestPrice = self.lowestPrice
        hotelViewModel.highestPrice = self.highestPrice
        hotelViewModel.isUseFilter = true
        hotelViewModel.hotelsCondition()
        isRefresh = false
    }
    
    func clear() {
        hotelViewModel.isUseFilter = false
        hotelViewModel.isTrainSelected = false
        hotelViewModel.isTrainhadTap?(false)
        isRefresh = true
    }
    
    func defaultRange() -> (min: Int, max: Int) {
        return (manager.lowestPrice ?? 0, manager.highestPrice ?? 0)
    }
    
    func changeRange(min: CGFloat, max: CGFloat) {
        highestPosition = max
        LowestPosition = min
    }
    
    func defaultFilter(){
        highestPosition = nil
        LowestPosition = nil
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
        hotelViewModel.isTrainSelected = false
        hotelViewModel.isTrainhadTap?(false)
    }
    
    
    func returnToDefault() {
        hotelViewModel.isTrainSelected = hotelViewModel.defaultTrainSelected()
        hotelViewModel.isTrainhadTap?(hotelViewModel.defaultTrainSelected())
    }
    
    func getlowestPrice() -> Int? {
        return hotelViewModel.defaultLowestPrice()
    }
    
    func getHighestPrice() -> Int? {
        return hotelViewModel.defaultHighestPrice()
    }
}
