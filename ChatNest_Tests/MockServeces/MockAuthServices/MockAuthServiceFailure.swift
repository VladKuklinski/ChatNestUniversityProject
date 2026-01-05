//
//  MockAuthServiceFailure.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger
import UIKit
import FirebaseAuth

class MockAuthServiceFailure : AuthServiceProtocol {
    
    func setUserSession(_ user: FirebaseAuth.User?) async {
        
    }
    
    struct DeletingAccountError : LocalizedError {
        var errorDescription: String? {"Failed to delete account"}
    }
    struct LoginError : LocalizedError {
        var errorDescription: String? {"Failed to login"}
    }
    struct CreatingUserError : LocalizedError {
        var errorDescription: String? {"Failed to create a user"}
    }
    struct ChangingEmailError : LocalizedError {
        var errorDescription: String? {"Failed to change an email"}
    }
    struct ResetPasswordError : LocalizedError {
        var errorDescription: String? {"Failed reset password"}
    }
    struct SigningOutError : LocalizedError {
        var errorDescription: String? {"Failed to sign out"}
    }
    
    func deleteAccount() async throws {
        throw DeletingAccountError()
    }
    
    
    func sendPasswordReset(email: String) async throws {
        throw ResetPasswordError()
    }
    
    func login(email: String, password: String) async throws {
        throw LoginError()
    }
    
    func createUser(fullName: String, email: String, password: String, profileImage: UIImage?) async throws {
        throw CreatingUserError()
    }
    
    func signOut() async throws{
        throw SigningOutError()
    }
    
    func uploadUserData(user: MyNewMessanger.User) async throws {
    
    }
    
    func updateEmail(newEmail: String) async throws {
        throw ChangingEmailError()
    }
    
    
}
