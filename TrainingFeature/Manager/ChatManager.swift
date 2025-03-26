//
//  ChatManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation

class ChatManager {
    
    private var coreData: ChatCoreDataManager = ChatCoreDataManager()
    
    private let ownerUser = ChatUser(name: "Me", image: "figure.child.circle.fill")
    
    private let chatList = [
        ChatUser(name: "Candy", image: "person.circle.fill"),
        ChatUser(name: "Josh", image: "figure.run.circle.fill"),
        ChatUser(name: "Tim", image: "figure.roll.circle.fill"),
    ]
    
    private let messageList = ["YAaa!", "Hey~~", "How r u?", "Good!"]
    
    private let stickerList = ["Hello", "app", "sheet", "save", "login", "chat", "cola"]
    
    private var chatHistory: [HistoryData] = []
    
    func getChatHistory() -> [HistoryData] {
       let data = coreData.fetchChatHistory()
        data.forEach { data in
            chatHistory.append(HistoryData(user: ChatUser(name: data.userName ?? "",
                                                          image: data.userImage ?? ""),
                                           time: data.time ?? Date(),
                                           isUseSticker: data.isUseImage,
                                           massage: data.massage ?? nil,
                                           sticker: data.sticker ?? nil
                                          ))
        }
        return chatHistory
    }
    
    func saveChatHistory(_ data: HistoryData) {
        chatHistory.append(data)
        saveToCoreData(chatHistory.last!)
    }
    
    func deleteAllChatHistory() {
        chatHistory.removeAll()
        coreData.deleteAllChatHistory()
    }
    
    func getStickerDate() -> [String] {
        return stickerList
    }
    
    func getChatUser() -> [ChatUser]{
        return chatList
    }
    
    func getMassageData() -> [String] {
        return messageList
    }
    
    func getOwerUserData() -> ChatUser {
        return ownerUser
    }
}


extension ChatManager {
    
    private func saveToCoreData(_ data: HistoryData) {
        let context = coreData.context
        let history = History(context: context)
        history.userName = data.user.name
        history.userImage = data.user.image
        history.time = data.time
        history.isUseImage = data.isUseSticker
        history.massage = data.massage
        history.sticker = data.sticker
        coreData.saveContext()
    }
}
