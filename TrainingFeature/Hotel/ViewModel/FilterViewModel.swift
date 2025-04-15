//
//  FilterViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/9.
//

import Foundation

class FilterViewModel { 
    
    static let shared = FilterViewModel()
    
    private let hotelViewModel: HotelSearchViewModel = .shared
    private let trainViewModel: TrainViewModel = .shared
    
    var defaultHighestPosition: CGFloat?
    var defaultLowestPosition: CGFloat?
    var defaultLowestPrice: Int?
    var defaultHighestPrice: Int?
    var defaultTrainisSelected: Bool?
    
    var isTrainSelected: Bool?

    var lowestPrice: Int?
    var highestPrice: Int?
    var isRefresh: Bool = false
    
    var highestPosition: CGFloat?
    var LowestPosition: CGFloat?
    
    private let manager: HotelAPIManager = .shared
    
    init() {
        defaultInitial()
    }
 
    // 確認後更改到 hotelViewModel
    func confirm() {
        hotelViewModel.lowestPrice = self.lowestPrice
        hotelViewModel.highestPrice = self.highestPrice
        hotelViewModel.isUseFilter = isUseFilter()
        hotelViewModel.isTrainSelected = trainViewModel.isSelected // 為了讓 hotelViewModel 正確更新
        hotelViewModel.hotelsCondition()
        
        isRefresh = false
    }
    
    // 唯獨自己更新
    func clear() {
        hotelViewModel.isUseFilter = isUseFilter()
        hotelViewModel.isTrainhadTap?(false)
        lowestPrice = defaultLowestPrice
        highestPrice = defaultHighestPrice
        
        isRefresh = true
        hotelViewModel.isUseFilter = isUseFilter()
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
}


extension FilterViewModel {

    private func defaultInitial() {
        defaultHighestPosition = 0
        defaultLowestPosition = 0
        defaultLowestPrice = manager.lowestPrice
        defaultHighestPrice = manager.highestPrice
        defaultTrainisSelected = hotelViewModel.isTrainSelected
        isTrainSelected = hotelViewModel.isTrainSelected
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
    }
    
    private func isUseFilter() -> Bool {
        return manager.lowestPrice != lowestPrice || manager.highestPrice != highestPrice
    }
}
