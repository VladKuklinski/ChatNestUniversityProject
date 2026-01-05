//
//  FacebookAuthService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 27/09/2025.
//

import Foundation
import FacebookLogin
import FacebookCore
import FirebaseAuth
import FirebaseFirestore

class FacebookAuthService: FacebookAuthServiceProtocol {
    private var userService: UserServiceProtocol
    private var authService: AuthServiceProtocol

    init(userService: UserServiceProtocol, authService: AuthServiceProtocol) {
        self.userService = userService
        self.authService = authService
    }

    func login() async throws -> FirebaseAuth.User {
        let token = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, Error>) in
            Task { @MainActor in
                let loginManager = LoginManager()
                loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    guard let accessToken = AccessToken.current?.tokenString else {
                        continuation.resume(throwing: NSError(domain: "FacebookAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No access token"]))
                        return
                    }
                    continuation.resume(returning: accessToken)
                }
            }
        }

        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        let authResult = try await Auth.auth().signIn(with: credential)
        let firebaseUser = authResult.user
        let fbImageUrl = try await fetchFacebookProfileImage()

        try await userService.fetchUserData(uid: nil)
        let currentUser = userService.currentUser
        let fullName = currentUser?.fullName ?? firebaseUser.displayName ?? "New User"
        let email = firebaseUser.email ?? ""
        let imageUrl = fbImageUrl ?? firebaseUser.photoURL?.absoluteString

        let newUser = User(
            uid: firebaseUser.uid,
            fullName: fullName,
            email: email,
            imageUrl: imageUrl,
            isActive: true,
            lastActive: Date()
        )

        try await authService.uploadUserData(user: newUser)
        userService.currentUser = newUser
        return firebaseUser
    }

    private func fetchFacebookProfileImage() async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            let request = GraphRequest(
                graphPath: "me",
                parameters: ["fields": "picture.type(large)"],
                tokenString: AccessToken.current?.tokenString,
                version: nil,
                httpMethod: .get
            )

            request.start { _, result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let dict = result as? [String: Any],
                   let picture = dict["picture"] as? [String: Any],
                   let data = picture["data"] as? [String: Any],
                   let url = data["url"] as? String {
                    continuation.resume(returning: url)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
