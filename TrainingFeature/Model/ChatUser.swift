//
//  ChatUser.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation
import UIKit

struct ChatUser {
    
    var name: String
    var image: String
}

struct HistoryData {
    
    var user: ChatUser
    var time: String
    var isUseImage: Bool
    var massage: String?
    var image: String?
}
