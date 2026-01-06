//
//  LoginView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI
import PhotosUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewModel(authService: AuthService(activityManager: ActivityStatusManager(), userService: UserService.shared))
    @State var showErrorAlert = false
    @State private var showPassword = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 40)
                Image("messengerLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text("Welcome to ChatNest")
                    .font(.title)
                Spacer()
                    .frame(height: 80)
                VStack(alignment: .trailing, spacing: 10) {
                    TextField("Write email", text: $viewModel.email)
                        .padding(12)
                        .background(Color(.systemGroupedBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemGroupedBackground))
                            .frame(height: 50)
                        
                        HStack {
                            if showPassword {
                                TextField("Write password", text: $viewModel.password)
                            } else {
                                SecureField("Write password", text: $viewModel.password)
                            }
                            
                            Button(action: { showPassword.toggle() }) {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    NavigationLink {
                        PasswordResetView()
                    } label: {
                        Text("Forgot password?")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
                    .frame(height: 70)
                
                Button {
                    Task {
                        await viewModel.login()
                        if viewModel.errorMessage != nil {
                            showErrorAlert.toggle()
                        }
                    }
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
                Divider()
                    .padding(.bottom)
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign in")
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(.horizontal, 15)
            .alert("Error", isPresented: $showErrorAlert, presenting: viewModel.errorMessage) { _ in
                Button("OK", role: .cancel) {
                    viewModel.email = ""
                    viewModel.password = ""
                }
            } message: { message in
                Text(message)
            }
        }
    }
}

#Preview {
    LoginView()
}

