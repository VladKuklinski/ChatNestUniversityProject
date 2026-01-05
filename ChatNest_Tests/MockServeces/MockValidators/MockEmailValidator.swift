//
//  MockEmailValidator.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import Foundation
@testable import MyNewMessanger

class MockEmailValidator_success : EmailValidatorProtocol {
    func isValidEmail(_ email: String) -> Bool {
        true
    }
}

class MockEmailValidator_failure : EmailValidatorProtocol {
    func isValidEmail(_ email: String) -> Bool {
        false
    }
}
