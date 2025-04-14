//
//  SortMenuViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/14.
//

import Foundation

class SortMenuViewModel {
    
    static let shared: SortMenuViewModel = SortMenuViewModel()
    
    var sortType: HotelSearchViewModel.SortType = .defaultSort
    
    private let hotelViewModel: HotelSearchViewModel = .shared

    init() {
        self.sortType = hotelViewModel.sortType
    }
    
    func updateSortType(_ type: HotelSearchViewModel.SortType){
        hotelViewModel.sortType = self.sortType
        hotelViewModel.hotelsSort()
    }
}
