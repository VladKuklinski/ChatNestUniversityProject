//
//  FriendListService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 19/09/2025.
//

import Foundation
import FirebaseFirestore

class FriendListService: FriendListServiceProtocol {
    private let db = Firestore.firestore()
    static let shared = FriendListService()

    func fetchSentRequest(for uid: String) async throws -> [User] {
        var allRequest: [User] = []
        let doc = try await db.collection("users").document(uid).getDocument()
        let user = try doc.data(as: User.self)
        let friendSentUIDs = user.outgoingRequests
        guard !friendSentUIDs.isEmpty else { return [] }

        for chunk in friendSentUIDs.chunked(into: 10) {
            let snapshot = try await db.collection("users")
                .whereField(FieldPath.documentID(), in: chunk)
                .getDocuments()
            allRequest += snapshot.documents.compactMap { try? $0.data(as: User.self) }
        }
        return allRequest
    }

    func fetchFriends(for uid: String) async throws -> [User] {
        var allFriends: [User] = []
        let doc = try await db.collection("users").document(uid).getDocument()
        let user = try doc.data(as: User.self)
        let friendsUIDs = user.friends
        guard !friendsUIDs.isEmpty else { return [] }

        for chunk in friendsUIDs.chunked(into: 10) {
            let snapshot = try await db.collection("users")
                .whereField(FieldPath.documentID(), in: chunk)
                .getDocuments()
            allFriends += snapshot.documents.compactMap { try? $0.data(as: User.self) }
        }
        return allFriends
    }

    func fetchIncomingRequest(for uid: String) async throws -> [User] {
        var allRequest: [User] = []
        let doc = try await db.collection("users").document(uid).getDocument()
        let user = try doc.data(as: User.self)
        let friendRequestUIDs = user.incomingRequests
        guard !friendRequestUIDs.isEmpty else { return [] }

        for chunk in friendRequestUIDs.chunked(into: 10) {
            let snapshot = try await db.collection("users")
                .whereField(FieldPath.documentID(), in: chunk)
                .getDocuments()
            allRequest += snapshot.documents.compactMap { try? $0.data(as: User.self) }
        }
        return allRequest
    }
}


