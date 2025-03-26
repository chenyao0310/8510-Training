//
//  Response.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/25.
//

import Foundation

struct Response: Decodable {
    var Module_List: [Module_List]
}

struct Module_List: Decodable {
    var ModuleItem_List: [ModuleItem_List]
    var Module_Remark: String
    var Module_Text: String
    var Index_Max: Int
    var Other_Max: Int
}

struct ModuleItem_List: Decodable {
    var Item_Price: Int
    var Item_Text: String
    var Pic_Url: String
}
