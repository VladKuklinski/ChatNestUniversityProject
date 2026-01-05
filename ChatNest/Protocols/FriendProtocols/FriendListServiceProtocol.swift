//
//  FriendListServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 19/09/2025.
//

import Foundation

protocol FriendListServiceProtocol {
    func fetchFriends(for uid: String) async throws -> [User]
    func fetchIncomingRequest(for uid: String) async throws -> [User]
    func fetchSentRequest(for uid: String) async throws -> [User]
}

