//
//  TrainViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/10.
//

import Foundation

class TrainViewModel {
    
    static let shared: TrainViewModel = TrainViewModel()
    
    var filterTrainDidChange: (() -> Void)?
    var trainSelectedDidChange: ((Bool) -> Void)?
    var isSelectedDidChange: (() -> Void)?
    
    var isSelected: Bool = false
    
    func updateTrainSelected(_ bool: Bool) {
        trainSelectedDidChange?(bool)
    }
}
