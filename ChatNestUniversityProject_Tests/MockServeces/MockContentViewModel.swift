//
//  MockContentViewModel.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger
import FirebaseAuth

class MockContentViewModel : ContentViewModelProtocol {
    var currentUser: FirebaseAuth.User?
    
}
