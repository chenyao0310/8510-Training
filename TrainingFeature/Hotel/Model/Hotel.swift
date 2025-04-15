//
//  Hotel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/4/1.
//

import Foundation

struct Hotel: Decodable {
    var hotelList: [Hotel_List]
    
    enum CodingKeys: String, CodingKey {
        case hotelList = "Hotel_List"
    }
}

struct Hotel_List: Decodable {
    var Add_On: [String]?
    var Short_Promotion: String
    var TWD_RetailPrice_Value: Int
    var Hotel_Longitude: Double
    var Recommendation: String
    var Location_Name: String
    var Price_Prefix: String
    var TWD_RetailPrice_Original: String
    var Member_Label: String
    var TWD_RetailPrice: String
    var Distance: String?
    var Overall: String
    var Hotel_No: Int
    var Hotel_Grade: Double
    var Hotel_Name: String
    var Hotel_Latitude: Double
    var Is_Hot: Bool
    var Img_Url: String
}


