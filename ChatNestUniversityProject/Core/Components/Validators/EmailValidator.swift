//
//  emailValidator.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 14/09/2025.
//

import Foundation

class EmailValidator : EmailValidatorProtocol {
    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
}


