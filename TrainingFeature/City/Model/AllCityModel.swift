//
//  AllCityModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/28.
//

import Foundation

struct AllCityModel: Decodable {
    var Country: [Country]
    
    enum CodingKeys: String, CodingKey {
        case Country = "Country_List"
    }
}

struct Country: Decodable {
    var Country_Code: String
    var Country_Name: String
    var City_List: [CityList]
}

struct CityList: Decodable {
    var City_Code: String
    var City_Name: String
}
