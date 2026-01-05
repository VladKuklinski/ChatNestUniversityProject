//
//  FirestoreService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 17/09/2025.
//
import FirebaseFirestore

class FirestoreService: FirestoreServiceProtocol {
    func changeUserName(uid: String, newName: String) async throws {
        do {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData(["fullName": newName])
        } catch {
            throw error
        }
    }
}
