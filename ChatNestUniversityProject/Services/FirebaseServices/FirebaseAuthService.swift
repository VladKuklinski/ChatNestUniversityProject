//
//  FirebaseAuthService.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService : FirebaseAuthServiceProtocol {
    var currentUserUid: String? {
        Auth.auth().currentUser?.uid
    }
}
