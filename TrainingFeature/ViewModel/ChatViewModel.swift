//
//  ChatViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/18.
//

import Foundation
import UIKit

class ChatViewModel {
    
    private let manager: ChatManager = ChatManager()
    
    var user = ""
    var userimage = ""
    var time = Date()
    var massage: String?
    var image: String?
    var isUseImage: Bool = false
    var history: [HistoryData] = []

    var onOwnerUsersChanged: (() -> Void)?
    var onMassageChanged: (() -> Void)?
    
    init () {
        history = manager.chatHistory
    }
    
    func getHistory(at index: Int) -> HistoryData {
        return history[index]
    }
    
    func replyMassage()  {
        
        guard let user = chatrandomUser() else { return }
        var massage = ""
        var image = ""
        isUseImage = .random()
        if isUseImage {
            image = chatRandomImage()
        } else {
            massage = chatRandomMassage()
        }
        let timeString = dateFormatter()
        let data = HistoryData(user: user,
                               time: timeString,
                               isUseImage: isUseImage,
                               massage: massage,
                               image: image)
    
        manager.chatHistory.append(data)
        history.append(data)
        onMassageChanged?()
    }
    
    func sendMassage(massage: String?, image: String?)  {
        isUseImage = false
        let timeString = dateFormatter()
        let data = HistoryData(user: manager.ownerUser,
                               time: timeString,
                               isUseImage: isUseImage,
                               massage: massage,
                               image: image)
        
        manager.chatHistory.append(data)
        history.append(data)
        onOwnerUsersChanged?()
    }
}

extension ChatViewModel {
    
    private func dateFormatter() -> String {
        let DateFormatter = DateFormatter()
        DateFormatter.dateFormat = "HH:mm"
        let timeString = DateFormatter.string(from: time)
        return timeString
    }
    
    private func chatrandomUser() -> ChatUser? {
        return manager.chatList.randomElement() ?? nil
    }
    
    private func chatRandomImage() -> String {
        return manager.imageList.randomElement() ?? "Hello"
    }
    
    private func chatRandomMassage() -> String {
        return manager.messageList.randomElement() ?? ""
    }
}
