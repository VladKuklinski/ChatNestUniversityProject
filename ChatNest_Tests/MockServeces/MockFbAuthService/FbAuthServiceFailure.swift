//
//  FbAuthServiceFailure.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger
import FirebaseAuth

class mockFbAuthServiceFailure : FacebookAuthServiceProtocol {
    struct LoginError : LocalizedError {
        var errorDescription: String? {"Some Problems"}
    }
    func login() async throws -> FirebaseAuth.User {
        throw LoginError()
    }
    
    
}
