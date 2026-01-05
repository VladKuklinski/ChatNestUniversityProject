//
//  MockFirestoreService.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger

class MockFirestoreService_failure : FirestoreServiceProtocol {
    var newUserName : String?
    var currentUserUid : String?
    
    struct ChangeUserNameError : LocalizedError {
        var errorDescription: String? {"Failed change user name"}
    }
    
    func changeUserName(uid: String, newName: String) async throws {
        throw ChangeUserNameError()
    }
        
    
    
}
