//
//  MockFirebaseAuthService.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger

class MockFirebaseAuthService : FirebaseAuthServiceProtocol {
    var currentUserUid: String? = mockUser1.uid
}
