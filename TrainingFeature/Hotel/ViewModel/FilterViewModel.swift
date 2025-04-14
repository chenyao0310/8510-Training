//
//  FilterViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/9.
//

import Foundation

class FilterViewModel { // SubViewModel
    
    static let shared = FilterViewModel()
    
    var defaultHighestPosition: CGFloat?
    var defaultLowestPosition: CGFloat?
    var defaultLowestPrice: Int?
    var defaultHighestPrice: Int?

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

        
        print("FilerViewModel init")
        lowestPrice = manager.lowestPrice
        highestPrice = manager.highestPrice
    }
 
    
//    func updateFilter(lowestPrice: Int?, highestPrice: Int?) {
//        NotificationCenter.default.post(name: .didUpdateHighestPrice, object: nil, userInfo: ["highestPrice": highestPrice ?? 0])
//        NotificationCenter.default.post(name: .didUpdateLowestPrice, object: nil, userInfo: ["lowestPrice": lowestPrice ?? 0])
//    }
//    
    func confirm() {
        confirmDidTap?()
        manager.hotelsFilter(min: lowestPrice ?? 0, max: highestPrice ?? 0)
        isRefresh = false
    }
    
    func clear() {
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
    }
}
