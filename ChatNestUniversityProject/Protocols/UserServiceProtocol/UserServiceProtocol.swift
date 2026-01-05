//
//  UserServiceProtocol.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 15/09/2025.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    var currentUserPublisher: AnyPublisher<User?, Never> {get}
    var currentUser: User? { get set }
    func fetchUserData(uid : String?) async throws
    func fetchAllUsers() async throws -> [User]
}
