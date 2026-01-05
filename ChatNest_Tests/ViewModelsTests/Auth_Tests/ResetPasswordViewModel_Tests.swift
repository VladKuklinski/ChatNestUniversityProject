//
//  ResetPasswordViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class ResetPasswordViewModel_Tests: XCTestCase {
    @MainActor func test_resetPassword_success() async {
        
        let authService = MockAuthServiceSuccess()
        let emailValidator = MockEmailValidator_success()
        let viewModel = PasswordResetViewModel(authService: authService,
                                               emailValidator:emailValidator)
        viewModel.email = "test@gmail.com"
        
        //
        await viewModel.resetPassword()
        //
        
        XCTAssertEqual(viewModel.message, "A reset link was sent to \(viewModel.email)")
        XCTAssertTrue(viewModel.sentWithSuccess)
    }
    
    @MainActor func test_resetPassword_failure() async {
        let authService = MockAuthServiceFailure()
        let emailValidator = MockEmailValidator_success()
        let viewModel = PasswordResetViewModel(authService: authService,
                                               emailValidator:emailValidator)
        viewModel.email = "test@gmail.com"
        
        //
        await viewModel.resetPassword()
        //
        XCTAssertEqual(viewModel.message, "Failed to send a link: Failed reset password")
        XCTAssertFalse(viewModel.sentWithSuccess)
    }
    
    @MainActor func test_resetPassword_invalidEmail() async {
        let authService = MockAuthServiceSuccess()
        let emailValidator = MockEmailValidator_failure()
        let viewModel = PasswordResetViewModel(authService: authService,
                                               emailValidator:emailValidator)
        viewModel.email = "testfdf#km"
        //
        await viewModel.resetPassword()
        //
        XCTAssertEqual(viewModel.message, "Invalid email format")
        XCTAssertFalse(viewModel.sentWithSuccess)
    }
    
    @MainActor func test_resetPassword_emptyEmail() async {
        let authService = MockAuthServiceSuccess()
        let emailValidator = MockEmailValidator_success()
        let viewModel = PasswordResetViewModel(authService: authService,
                                               emailValidator:emailValidator)
        viewModel.email = ""
        //
        await viewModel.resetPassword()
        //
        XCTAssertEqual(viewModel.message, "Please enter your email")
        XCTAssertFalse(viewModel.sentWithSuccess)
    }
}
