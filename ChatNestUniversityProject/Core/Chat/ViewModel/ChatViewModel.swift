//
//  ChatViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 05/08/2025.
//

import Foundation

class ChatViewModel : ObservableObject {
    @Published var textMessage = ""
    @Published var messages : [Message] = []
    var user : User
    private let sendingMessageService : SendingMessageServiceProtocol
    private let observingMessageService : ObservingMessageServiceProtocol

    init(user: User,
         sendingMessageService : SendingMessageServiceProtocol,
         observingMessageService : ObservingMessageServiceProtocol) {
        self.user = user
        self.sendingMessageService = sendingMessageService
        self.observingMessageService = observingMessageService
        observeMessages()
    }
    func observeMessages() {
        observingMessageService.observeMessages(chatPartner: user) { messages in
            self.messages.append(contentsOf: messages)
        }
    }
    func sendMessage() {
        sendingMessageService.sendMessage(textMessage, toUser: user)
    }
}
