//
//  FilterViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/9.
//

import Foundation

class FilterViewModel {
    
    static let shared = FilterViewModel()
    
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
    
    var isTrainhadTap: ((Bool) -> Void)?
    var filterConfirm: (() -> Void)?
    var filterCancel: (() -> Void)?
    var setUpDefaultFilter: (() -> Void)?
    var setUpReturnToDefault: (() -> Void)?
    var lowestDidChange: (() -> Bool)?
    var highestDidChange: (() -> Bool)?
    var getDefaultPriceRange: (() -> (lowest: Int, highest: Int))?
    
    init() {
        defaultInitial()
    }
 
    // 確認後更改到 hotelViewModel
    func confirm() {
        filterConfirm?()
    }
    
    // 唯獨自己更新
    func clear() {
        filterCancel?()
    }
    
    func defaultPriceRange() -> (min: Int, max: Int) {
        return getDefaultPriceRange?() ?? (0, 0)
    }
    
    func changeRange(min: CGFloat, max: CGFloat) {
        highestPosition = max
        LowestPosition = min
    }
    
    func defaultFilter(){
        setUpDefaultFilter?()
    }
    
    func returnToDefault() {
        setUpReturnToDefault?()
    }
    
    func isUseFilter() -> Bool {
        return lowestDidChange?() ?? false || highestDidChange?() ?? false
    }
}

extension FilterViewModel {

    func defaultInitial(defaultHighPrice: Int = 0, defaultLowPrice: Int = 0, trainSelected: Bool = false) {
        defaultHighestPosition = 0
        defaultLowestPosition = 0
        defaultLowestPrice = defaultLowPrice
        defaultHighestPrice = defaultHighPrice
        defaultTrainisSelected = trainSelected
        isTrainSelected = trainSelected
        lowestPrice = defaultLowPrice
        highestPrice = defaultHighPrice
    }
}
