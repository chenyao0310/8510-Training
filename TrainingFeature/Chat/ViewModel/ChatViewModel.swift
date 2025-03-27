//
//  ChatViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation
import UIKit

class ChatViewModel {
    
    private let coreData: ChatCoreDataManager = .shared
    
    var user = ""
    var userimage = ""
    var time = Date()
    var massage: String?
    var sticker: String?
    var isUseImage: Bool = false
    var chatHistory: [HistoryData] = []
    var isShowStickers: Bool = false
    let stickerList = ["Hello", "app", "sheet", "save", "login", "chat", "cola"]
    var isMeSendMassage: Bool = false
    var onOwnerUsersChanged: (() -> Void)?
    var onMassageChanged: (() -> Void)?
    
    private let ownerUser = ChatUser(name: "Me", image: "figure.child.circle.fill")
    private let chatList = [
        ChatUser(name: "Candy", image: "person.circle.fill"),
        ChatUser(name: "Josh", image: "figure.run.circle.fill"),
        ChatUser(name: "Tim", image: "figure.roll.circle.fill"),
    ]
    private let messageList = ["YAaa!", "Hey~~", "How r u?", "Good!"]
    
    init () {
        getChatHistory()
        threeFirendRandomTalk()
    }
    
    func getHistory(at index: Int) -> HistoryData {
        return chatHistory[index]
    }
    
    func replyMassage() {
        guard let user = chatrandomUser() else { return }
        var massage = ""
        var sticker = ""
        isUseImage = .random()
        if isUseImage {
            sticker = chatRandomImage()
        } else {
            massage = chatRandomMassage()
        }
        let data = HistoryData(user: user,
                               time: time,
                               isUseSticker: isUseImage,
                               massage: massage,
                               sticker: sticker)
        historySave(data)
        onMassageChanged?()
    }
    
    func sendMassage(massage: String?, sticker: String?) {
        isMeSendMassage = true
        isUseImage = sticker != nil
        let data = HistoryData(user: ownerUser,
                               time: time,
                               isUseSticker: isUseImage,
                               massage: massage,
                               sticker: sticker)
        historySave(data)
        onOwnerUsersChanged?()
        isMeSendMassage = false
    }
    
    func threeFirendRandomTalk() {
        if chatHistory.isEmpty {
            for _ in 0...4 {
                replyMassage()
            }
        }
    }
}

extension ChatViewModel {
    
    private func getChatHistory() {
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
    }

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
    
    private func historySave(_ data: HistoryData) {
        chatHistory.append(data)
        saveToCoreData(chatHistory.last!)
    }
    
    private func deleteHistory() {
        chatHistory.removeAll()
        coreData.deleteAllChatHistory()
    }
    
    private func chatrandomUser() -> ChatUser? {
        return chatList.randomElement() ?? nil
    }
    
    private func chatRandomImage() -> String {
        return stickerList.randomElement() ?? "Hello"
    }
    
    private func chatRandomMassage() -> String {
        return messageList.randomElement() ?? ""
    }
}
