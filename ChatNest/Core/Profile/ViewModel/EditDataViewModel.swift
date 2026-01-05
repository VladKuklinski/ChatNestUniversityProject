//
//  EditDataViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 08/09/2025.
//
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class EditDataViewModel : ObservableObject{
    @Published var message : String?
    @Published var email = ""
    @Published var sentWithSuccess = false
    private let userService : UserServiceProtocol
    private let firestoreService : FirestoreServiceProtocol
    private let authService : AuthServiceProtocol
    
    init(userService: UserServiceProtocol,
         firestoreService : FirestoreServiceProtocol = FirestoreService(),
         authService : AuthServiceProtocol
    ) {
        self.userService = userService
        self.firestoreService = firestoreService
        self.authService = authService
    }
    func changeName(newName : String) async throws {
        do {
            guard let currentUserUid = userService.currentUser?.uid else {return}
            try await firestoreService.changeUserName(uid: currentUserUid, newName: newName)
            try await userService.fetchUserData(uid: currentUserUid)
        } catch {
            await MainActor.run {
                self.message = "Failed to change a name: \(error.localizedDescription)"
            }
        }
    }
    func changeEmail(to newEmail : String) async throws {
        do {
            try await authService.updateEmail(newEmail: newEmail)
            await MainActor.run {
                self.message = "A reset link was sent to new email: \(newEmail)"
                self.sentWithSuccess.toggle()
            }
        } catch {
            await MainActor.run {
                self.message = "Failed to send a link: \(error.localizedDescription)"
            }
        }
    }
}
