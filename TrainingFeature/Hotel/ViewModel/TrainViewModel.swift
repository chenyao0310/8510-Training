//
//  TrainViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/10.
//

import Foundation

class TrainViewModel {
    
    static let shared: TrainViewModel = TrainViewModel()
    
    private let hotelViewModel: HotelSearchViewModel = .shared
    
    var isSelectedDidChange: (() -> Void)?
    
    var isSelected: Bool = false
    
    init() {
        self.isSelected = hotelViewModel.isTrainSelected
        hotelViewModel.isTrainhadTap = { [weak self] bool in // filterView 更新按鈕
            self?.isSelected = bool
            self?.isSelectedDidChange?() // 更新 UI
        }
    }
    
    func updateTrainSelected(_ bool: Bool) {
        hotelViewModel.isTrainSelected = bool
        hotelViewModel.hotelsCondition()
    }
}
