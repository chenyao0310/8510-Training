//
//  SortMenuViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/14.
//

import Foundation

class SortMenuViewModel {
    
    static let shared: SortMenuViewModel = SortMenuViewModel()
    
    var sortType: SortType = .defaultSort
    var sendSrotType: ((SortType) -> Void)?

    func updateSortType(_ type: SortType){
        sendSrotType?(type)
    }
}
