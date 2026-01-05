//
//  FacebookAuthServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 14/09/2025.
//

import Foundation
import FirebaseAuth

protocol FacebookAuthServiceProtocol {
    func login() async throws -> FirebaseAuth.User
}
