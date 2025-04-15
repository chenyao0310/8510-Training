//
//  HotelAPIManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

class HotelAPIManager {
    
    static let shared = HotelAPIManager()
    
    var hotels: [Hotel_List]?
    
    var lowestPrice: Int?
    var highestPrice: Int?
    
    var hotelsDidChange: (([Hotel_List]) -> Void)?
    
    private init() {
        defaultHotels()
    }
    
    func defaultHotels() {
        hotels = fetchHotels()
        getHotelLowestAndHighestPrice()
    }
}

extension HotelAPIManager {
    
    private func fetchHotels() -> [Hotel_List]? {
           guard let url = Bundle.main.url(forResource: "HotelList", withExtension: "json") else {
               fatalError("Couldnt find result in main bundle.")
           }
           do {
               let data = try Data(contentsOf: url)
               let response = try JSONDecoder().decode(Hotel.self, from: data)
               return response.hotelList
           } catch {
               print("decode result json failed -> \(error)")
           }
           return nil
       
    }
    
    private func getHotelLowestAndHighestPrice() {
        guard let hotels else { return }
        lowestPrice = hotels.sorted { $0.TWD_RetailPrice_Value < $1.TWD_RetailPrice_Value }.first?.TWD_RetailPrice_Value
        highestPrice = hotels.sorted { $0.TWD_RetailPrice_Value > $1.TWD_RetailPrice_Value }.first?.TWD_RetailPrice_Value
    }
}
