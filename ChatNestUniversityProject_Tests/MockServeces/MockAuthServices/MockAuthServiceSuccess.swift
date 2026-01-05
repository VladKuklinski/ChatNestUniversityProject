//
//  MockAuthServiceSuccess.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger
import UIKit
import FirebaseAuth

class MockAuthServiceSuccess : AuthServiceProtocol {
    func setUserSession(_ user: FirebaseAuth.User?) async {
        
    }
    
    func deleteAccount() async throws {
        
    }
    
    func sendPasswordReset(email: String) async throws {
        
    }
    
    func login(email: String, password: String) async throws {
        
    }
    
    func createUser(fullName: String, email: String, password: String, profileImage: UIImage?) async throws {
        
    }
    
    func signOut() async {
        
    }
    
    func uploadUserData(user: MyNewMessanger.User) async throws {
        
    }
    
    func updateEmail(newEmail: String) async throws {
        
    }
    
    
}
