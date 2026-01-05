//
//  MessageServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 15/09/2025.
//

import Foundation

protocol SendingMessageServiceProtocol {
     func sendMessage(_ textMessage: String, toUser user: User)
}

protocol ObservingMessageServiceProtocol {
     func observeRecentMessages(completion: @escaping ([Message]) -> Void)
     func observeMessages(chatPartner: User, completion: @escaping ([Message]) -> Void)
}
