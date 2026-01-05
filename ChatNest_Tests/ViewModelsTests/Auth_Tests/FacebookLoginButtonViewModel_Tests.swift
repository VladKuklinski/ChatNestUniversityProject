//
//  FacebookLoginButtonViewModel_Tests.swift
//  MyNewMessangerTests
//
//  Created by Vlad Kuklinski on 17/09/2025.
//

import XCTest
@testable import MyNewMessanger

final class FacebookLoginButtonViewModel_Tests: XCTestCase {
        
    
    @MainActor func test_login_failure() async {
        
        let mockContentViewModel = MockContentViewModel()
        let fbAuthService = mockFbAuthServiceFailure()
        let authService = MockAuthServiceFailure()
        let activityManager = MockActivityStatusManager()
        let viewModel = FacebookLoginButtonViewModel(fbAuthService: fbAuthService,
                                                     contentViewModel: mockContentViewModel,
                                                     authService: authService,
                                                     activityManager: activityManager)
        //
        await viewModel.login()
        //
        XCTAssertEqual(viewModel.errorMessage, "Some Problems")

    }
}
