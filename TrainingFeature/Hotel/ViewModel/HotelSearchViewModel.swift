//
//  HotelSearchViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

class HotelSearchViewModel {
    
    static let shared = HotelSearchViewModel()
    
    var hotels: [Hotel_List]? = []
    
    private let manager: HotelAPIManager = .shared
    
    init() {
        hotels = manager.fetchHotels()
        print("一共 \(hotels?.count ?? 0) fetched")
    }
}
