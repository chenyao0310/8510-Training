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
    
    var isSelected: Bool = false
    
    var onSelected: ((Bool) -> Void)?
    
    init() {
        self.isSelected = hotelViewModel.isTrainSelected
    }
    
    func updateSelected() {
        hotelViewModel.isTrainSelected = self.isSelected
    }
}
