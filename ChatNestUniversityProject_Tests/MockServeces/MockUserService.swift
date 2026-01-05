//
//  MockUserService.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 16/09/2025.
//

import Foundation
@testable import MyNewMessanger
import Combine

class MockUserService : UserServiceProtocol {
    let user1 = mockUser1
    let user2 = mockUser2
    private let currentUserSubject = CurrentValueSubject<User?, Never>(mockUser1)
    
    var currentUser: User? {
            get { currentUserSubject.value }
            set { currentUserSubject.send(newValue) }
        }
    
    var currentUserPublisher: AnyPublisher<User?, Never> {
            currentUserSubject.eraseToAnyPublisher()
        }
    
    
    func fetchUserData() async throws {
        self.currentUser = user1
    }
    
    func fetchAllUsers() async throws -> [User] {
        return [user1, user2]
    }
    
    
}
