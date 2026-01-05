//
//  FacebookLoginButtonView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 14/09/2025.
//

import SwiftUI

struct FacebookLoginButtonView: View {
    @StateObject var viewModel =
    FacebookLoginButtonViewModel(
        
        fbAuthService: FacebookAuthService(
            userService: UserService.shared,
            authService: AuthService.shared),
        
        contentViewModel: ContentViewModel(),
        
        authService: AuthService.shared,
        
        activityManager: ActivityStatusManager())
    
    @EnvironmentObject var contentViewModel: ContentViewModel
    @State var isLoading = false
    var body: some View {
        Button {
            isLoading = true
            Task { @MainActor in
                defer { isLoading = false }
                await viewModel.login()
            }
        } label: {
            if !isLoading {
                HStack {
                    Image("facebookLogo")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                    
                    Text("Continue with Facebook")
                        .font(.callout)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(Color.blue)
                .cornerRadius(8)
            } else {
                ProgressView()
            }
        }
        .disabled(viewModel.isLoading)
        .alert("Login Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

#Preview {
    FacebookLoginButtonView()
}
