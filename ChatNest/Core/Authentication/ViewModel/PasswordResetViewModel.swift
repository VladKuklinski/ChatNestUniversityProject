//
//  PasswordResetViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 05/09/2025.
//

import Foundation

@MainActor
class PasswordResetViewModel: ObservableObject {
    @Published var email = ""
    @Published var message : String?
    @Published var sentWithSuccess = false
    
    private let authService : AuthServiceProtocol
    private let emailValidator : EmailValidatorProtocol
    
    init(authService: AuthServiceProtocol, emailValidator: EmailValidatorProtocol) {
        self.authService = authService
        self.emailValidator = emailValidator
    }
    
    func resetPassword() async {
        guard !email.isEmpty else {
            message = "Please enter your email"
            return
        }
        
        guard emailValidator.isValidEmail(email) else {
            message = "Invalid email format"
            return
        }
        
        do {
            try await authService.sendPasswordReset(email: email)
            message = "A reset link was sent to \(email)"
            sentWithSuccess.toggle()
        } catch {
            message = "Failed to send a link: \(error.localizedDescription)"
            
        }
    }
}


