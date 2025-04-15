//
//  CtiyModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/28.
//

import Foundation

struct PopCtiyModel: Decodable {
    var ModuleItem: [ModuleItem]
    
    enum CodingKeys: String, CodingKey {
        case ModuleItem = "ModuleItem_List"
    }
}
