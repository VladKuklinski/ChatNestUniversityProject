//
//  AuthService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FacebookLogin

@MainActor
class AuthService: ObservableObject, AuthServiceProtocol {
    private var activityManager: ActivityStatusManagerProtocol
    private var userService: UserServiceProtocol

    @Published var userSession: FirebaseAuth.User?

    init(activityManager: ActivityStatusManagerProtocol, userService: UserServiceProtocol) {
        self.activityManager = activityManager
        self.userService = userService
        self.userSession = Auth.auth().currentUser
        if let uid = self.userSession?.uid {
            Task { @MainActor in
                try? await userService.fetchUserData(uid: uid)
                activityManager.setupOnlineStatus(for: uid)
            }
        }
    }

    static let shared = AuthService(
        activityManager: ActivityStatusManager(),
        userService: UserService.shared
    )

    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        activityManager.deleteStatus(for: uid)
        try await Firestore.firestore().collection("users").document(uid).delete()
        try await user.delete()
        await MainActor.run { self.userSession = nil }
        if Auth.auth().currentUser == nil { print("DEBUG: user was deleted") }
        LoginManager().logOut()
    }

    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
        print("DEBUG: Attempted to send link to email: \(email)")
    }

    func login(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        await self.setUserSession(result.user)
    }

    func createUser(fullName: String, email: String, password: String, profileImage: UIImage?) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        var imageUrl: String? = nil
        if let profileImage = profileImage {
            imageUrl = try await uploadProfileImage(profileImage, uid: result.user.uid)
        }
        let newUser = User(
            uid: result.user.uid,
            fullName: fullName,
            email: email,
            imageUrl: imageUrl,
            isActive: true,
            lastActive: Date()
        )
        try await self.uploadUserData(user: newUser)
        userService.currentUser = newUser
        await AuthService.shared.setUserSession(result.user)
        print("DEBUG: currentUser set -> \(newUser.fullName), url: \(newUser.imageUrl ?? "nil")")
    }

    private func uploadProfileImage(_ image: UIImage, uid: String) async throws -> String {
        guard let data = image.jpegData(compressionQuality: 0.5) else { throw URLError(.badServerResponse) }
        let ref = Storage.storage().reference(withPath: "\(Constants.imageLocation + uid).jpg")
        _ = try await ref.putDataAsync(data)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }

    func signOut() async throws {
        guard let uid = userService.currentUser?.uid else { return }
        activityManager.setupOfflineStatus(for: uid)
        try Auth.auth().signOut()
        userService.currentUser = nil
        userSession = nil
        LoginManager().logOut()
        print("DEBUG: User signed out")
    }

    func uploadUserData(user: User) async throws {
        guard let uid = user.uid, !uid.isEmpty else {
            print("DEBUG: uploadUserData -> user.uid is nil or empty")
            return
        }
        guard let encodedUser = try? Firestore.Encoder().encode(user) else {
            print("DEBUG: uploadUserData -> encoding failed")
            return
        }
        try await Firestore.firestore().collection("users").document(uid).setData(encodedUser)
        print("DEBUG: uploadUserData -> saved user \(uid)")
    }

    func updateEmail(newEmail: String) async throws {
        guard let user = Auth.auth().currentUser else { return }
        try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
    }

    @MainActor
    func setUserSession(_ user: FirebaseAuth.User?) async {
        AuthService.shared.userSession = user
        guard let uid = user?.uid else { return }
        do {
            try await userService.fetchUserData(uid: uid)
            activityManager.setupOnlineStatus(for: uid)
            print("DEBUG: User was fetched")
        } catch {
            print("DEBUG: Failed to fetch user - \(error.localizedDescription)")
        }
        print("set user session - user's name is \(String(describing: user))")
    }
}
