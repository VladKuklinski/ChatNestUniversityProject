//
//  MockFirestoreService.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger

class MockFirestoreService_success : FirestoreServiceProtocol {
    var newUserName : String?
    var currentUserUid : String?
    
    
    func changeUserName(uid: String, newName: String) async throws {
        currentUserUid = uid
        newUserName = newName
    }
    
    
}
