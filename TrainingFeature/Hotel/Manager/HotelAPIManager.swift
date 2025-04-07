//
//  HotelAPIManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

class HotelAPIManager {
    
    static let shared = HotelAPIManager()
    
    private init() {}
    
    func fetchHotels() -> [Hotel_List]? {
      
           guard let url = Bundle.main.url(forResource: "HotelList", withExtension: "json") else {
               fatalError("Couldnt find result in main bundle.")
           }
           do {
               let data = try Data(contentsOf: url)
               let response = try JSONDecoder().decode(Hotel.self, from: data)
               return response.Hotel_List
           } catch {
               print("decode result json failed -> \(error)")
           }
           return nil
       
    }
}
