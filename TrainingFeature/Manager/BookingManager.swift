//
//  BookingManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/19.
//

import Foundation

class BookingManager {
    
    static let shared = BookingManager()
    
    var adultCount: Int = 0 
    var childCount: Int = 0
    var seniorCount: Int = 0
    
    func save(adult: Int, child: Int, senior: Int) {
        adultCount = adult
        childCount = child
        seniorCount = senior
    }
    
    func getSting() -> String{
        return "\(adultCount)位大人 \(childCount)位小孩 \(seniorCount)位長者"
    }
}
