//
//  ChatManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation

class ChatManager {
    
    let ownerUser = ChatUser(name: "Me", image: "figure.child.circle.fill")
    
    let chatList = [
        ChatUser(name: "Candy", image: "person.circle.fill"),
        ChatUser(name: "Josh", image: "figure.run.circle.fill"),
        ChatUser(name: "Tim", image: "figure.roll.circle.fill"),
    ]
    
    let messageList = ["YAaa!", "Hey~~", "How r u?", "Good!"]
    
    let imageList = ["Hello"]
    
    var chatHistory: [HistoryData] = []
}
