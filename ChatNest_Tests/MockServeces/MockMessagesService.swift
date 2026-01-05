//
//  MockSendingMessagesService.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import Foundation
@testable import MyNewMessanger

class MockSendingMessagesService : SendingMessageServiceProtocol {
    
    var sentMessages : [(text : String, user : User)] = []
    func sendMessage(_ textMessage: String, toUser user: User) {
        sentMessages.append((textMessage, user))
    }
    
    
}


class MockObservingMessagesService : ObservingMessageServiceProtocol {
    
    var messagesToSend : [Message] = []
    var recentMessagesToSend : [Message] = []
    
    func observeRecentMessages(completion: @escaping ([Message]) -> Void) {
            completion(recentMessagesToSend)
        
    }
    
    func observeMessages(chatPartner: User, completion: @escaping ([Message]) -> Void) {
            completion(messagesToSend)
        
    }
    
    
}
