//
//  FriendRequestService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 19/09/2025.
//

import Foundation
import FirebaseFirestore

class FriendRequestService: FriendRequestServiceProtocol {
    private let db = Firestore.firestore()

    func sendRequest(from senderUID: String, to receiverUID: String) async throws {
        let senderRef = db.collection("users").document(senderUID)
        let receiverRef = db.collection("users").document(receiverUID)

        try await senderRef.updateData([
            "outgoingRequests": FieldValue.arrayUnion([receiverUID])
        ])
        try await receiverRef.updateData([
            "incomingRequests": FieldValue.arrayUnion([senderUID])
        ])
    }

    func acceptRequest(userUID: String, friendUID: String) async throws {
        let userRef = db.collection("users").document(userUID)
        let friendRef = db.collection("users").document(friendUID)

        try await userRef.updateData([
            "friends": FieldValue.arrayUnion([friendUID]),
            "incomingRequests": FieldValue.arrayRemove([friendUID])
        ])
        try await friendRef.updateData([
            "friends": FieldValue.arrayUnion([userUID]),
            "outgoingRequests": FieldValue.arrayRemove([userUID])
        ])
    }

    func cancelRequest(userUID: String, friendUID: String) async throws {
        let userRef = db.collection("users").document(userUID)
        let friendRef = db.collection("users").document(friendUID)

        try await userRef.updateData([
            "outgoingRequests": FieldValue.arrayRemove([friendUID])
        ])
        try await friendRef.updateData([
            "incomingRequests": FieldValue.arrayRemove([userUID])
        ])
    }

    func declineRequest(userUID: String, friendUID: String) async throws {
        let userRef = db.collection("users").document(userUID)
        let friendRef = db.collection("users").document(friendUID)

        try await userRef.updateData([
            "incomingRequests": FieldValue.arrayRemove([friendUID])
        ])
        try await friendRef.updateData([
            "outgoingRequests": FieldValue.arrayRemove([userUID])
        ])
    }

    func unfriend(userUID: String, friendUID: String) async throws {
        let userRef = db.collection("users").document(userUID)
        let friendRef = db.collection("users").document(friendUID)

        try await userRef.updateData([
            "friends": FieldValue.arrayRemove([friendUID])
        ])
        try await friendRef.updateData([
            "friends": FieldValue.arrayRemove([userUID])
        ])
    }
}


