//
//  UserService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Combine

class UserService: ObservableObject, UserServiceProtocol {
    @Published var currentUser: User?
    static let shared = UserService()

    var currentUserPublisher: AnyPublisher<User?, Never> {
        $currentUser.eraseToAnyPublisher()
    }

    @MainActor
    func fetchUserData(uid: String?) async throws {
        let uidToUse = uid ?? Auth.auth().currentUser?.uid
        guard let uid = uidToUse, !uid.isEmpty else {
            print("DEBUG: fetchUserData -> no uid available")
            return
        }

        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        print("DEBUG: fetchUserData snapshot.exists = \(snapshot.exists), data = \(snapshot.data() ?? [:]) for uid \(uid)")

        guard snapshot.exists else {
            print("DEBUG: fetchUserData -> no document for uid \(uid)")
            return
        }

        do {
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
            print("DEBUG: userService current user set -> \(user.fullName)")
        } catch {
            print("DEBUG: fetchUserData decode error -> \(error)")
        }
    }

    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: User.self) }
    }
}

