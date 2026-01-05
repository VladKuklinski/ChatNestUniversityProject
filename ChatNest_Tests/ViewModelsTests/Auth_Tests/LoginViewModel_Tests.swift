//
//  LoginViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class LoginViewModel_Tests: XCTestCase {

    @MainActor func test_login_success() async {
        let authService = MockAuthServiceSuccess()
        let viewModel = LoginViewModel(authService: authService)
        
        //
        await viewModel.login()
        //
        XCTAssertNil(viewModel.errorMessage)
    }

    @MainActor func test_login_failure() async {
        let authService = MockAuthServiceFailure()
        let viewModel = LoginViewModel(authService: authService)
        
        //
        await viewModel.login()
        //
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
