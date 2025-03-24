//
//  ChatViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation
import UIKit

class ChatViewModel {
    
    var user = ""
    var userimage = ""
    var time = Date()
    var massage: String?
    var sticker: String?
    var isUseImage: Bool = false
    var history: [HistoryData] = []
    var stickerList: [String] = []
    var isShowStickers: Bool = false

    var isMeSendMassage: Bool = false
    var onOwnerUsersChanged: (() -> Void)?
    var onMassageChanged: (() -> Void)?
    
    private let manager: ChatManager = ChatManager()
    
    init () {
        history = manager.getChatHistory()
        stickerList = manager.getStickerDate()
        threeFirendRandomTalk()
    }
    
    func getHistory(at index: Int) -> HistoryData {
        return history[index]
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
        let data = HistoryData(user: manager.getOwerUserData(),
                               time: time,
                               isUseSticker: isUseImage,
                               massage: massage,
                               sticker: sticker)
        historySave(data)
        onOwnerUsersChanged?()
        isMeSendMassage = false
    }
    
    func deleteHistory() {
        history.removeAll()
        manager.deleteAllChatHistory()
    }
    
    func threeFirendRandomTalk() {
        if history.isEmpty {
            for _ in 0...4 {
                replyMassage()
            }
        }
    }
}

extension ChatViewModel {
    
    private func historySave(_ data: HistoryData) {
        history.append(data)
        manager.saveChatHistory(history.last!)
    }
    
    private func chatrandomUser() -> ChatUser? {
        let users = manager.getChatUser()
        return users.randomElement() ?? nil
    }
    
    private func chatRandomImage() -> String {
        return stickerList.randomElement() ?? "Hello"
    }
    
    private func chatRandomMassage() -> String {
        let messageList = manager.getMassageData()
        return messageList.randomElement() ?? ""
    }
}
