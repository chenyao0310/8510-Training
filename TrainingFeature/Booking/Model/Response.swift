//
//  Response.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

struct Response: Decodable {
    var Module: [Module]
    
    enum CodingKeys: String, CodingKey {
        case Module = "Module_List"
    }
}

struct Module: Decodable {
    var ModuleItem_List: [ModuleItem]
    var Module_Remark: String
    var Module_Text: String
    var Index_Max: Int
    var Other_Max: Int
}

struct ModuleItem: Decodable {
    var Item_Price: Int
    var Item_Text: String
    var Pic_Url: String
}
