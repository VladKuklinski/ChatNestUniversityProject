//
//  AuthServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 14/09/2025.
//

import Foundation
import SwiftUI
import FirebaseAuth

protocol AuthServiceProtocol {
    func deleteAccount() async throws
    func sendPasswordReset(email : String) async throws
    func login(email : String, password : String) async throws
    func createUser(fullName: String, email : String, password: String, profileImage: UIImage?) async throws
    func signOut() async throws
    func uploadUserData(user: User) async throws
    func updateEmail(newEmail : String) async throws
    func setUserSession(_ user: FirebaseAuth.User?) async
}
