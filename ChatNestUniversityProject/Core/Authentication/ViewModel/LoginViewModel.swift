//
//  LoginViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation

@MainActor
class LoginViewModel : ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage : String?
    private let authService : AuthServiceProtocol
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    func login() async {
        do {
            try await authService.login(email: email, password: password)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
