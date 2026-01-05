//
//  FriendServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 19/09/2025.
//

import Foundation

protocol FriendRequestServiceProtocol {
    func sendRequest(from senderUID: String, to receiverUID: String) async throws
    func acceptRequest(userUID: String, friendUID: String) async throws
    func cancelRequest(userUID: String, friendUID: String) async throws
    func unfriend(userUID: String, friendUID: String) async throws
    func declineRequest(userUID : String, friendUID : String) async throws 
}
