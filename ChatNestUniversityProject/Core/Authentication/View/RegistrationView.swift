//
//  RefistrationView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI
import PhotosUI
struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel(authService: AuthService(activityManager: ActivityStatusManager(), userService: UserService.shared))
    @Environment(\.dismiss) var dismiss
    @State private var displayedImage: Image?
    @State var isLoading = false
    @State var repeatPassword = ""
    @State var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            PhotosPicker(selection: $viewModel.selectedImage) {
                if let image = displayedImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 84, height: 84)
                        .clipShape(Circle())
                } else {
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 84, height: 84)
                        
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                }
            }
            .onChange(of: viewModel.selectedImage) {
                Task { @MainActor in
                    try? await viewModel.setImage()
                }
            }
            .onChange(of: viewModel.profileImage) { _, newValue in
                Task { @MainActor in
                    displayedImage = newValue
                }
            }
            VStack(alignment: .trailing, spacing: 10) {
                TextField("Write your full name", text: $viewModel.fullName)
                    .autocorrectionDisabled(true)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                TextField("Write email", text: $viewModel.email)
                    .autocorrectionDisabled(true)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
                    .frame(height: 20)
                SecureField("Write password", text: $viewModel.password)
                    .textContentType(.none)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                SecureField("Repeat password", text: $repeatPassword)
                    .textContentType(.none)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.vertical, 30)
            VStack {
                Button {
                    guard viewModel.password == repeatPassword else {
                        viewModel.errorMessage = "Passwords are not the same"
                        showAlert.toggle()
                        return
                    }
                    isLoading = true
                    Task {
                        defer {isLoading = false}
                        await viewModel.signIn()
                        if viewModel.errorMessage != nil {
                            showAlert.toggle()
                        }
                    }
                    
                } label: {
                    if isLoading {
                        ProgressView()
                            .animation(nil, value: isLoading)
                    } else {
                        Text("Sign in")
                            .frame(maxWidth: .infinity)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                HStack {
                    Rectangle()
                        .frame(width: 165, height: 0.5)
                    Text("OR")
                        .font(.footnote)
                    Rectangle()
                        .frame(width: 165, height: 0.5)
                }
                .padding(.top, 6)
                
                .foregroundStyle(Color(.systemGray2))
                FacebookLoginButtonView()
                    .frame(height: 44)
                    .padding()
            }
            Spacer()
            Spacer()
            Divider()
                .padding(.bottom)
            Button {
                dismiss()
            } label: {
                HStack {
                    Text("Have an account already?")
                    Text("Log in")
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(.horizontal, 15)
        .alert("Error", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                viewModel.password = ""
                repeatPassword = ""
            }
        } message: {
            Text(viewModel.errorMessage ?? "Try again")
        }
        
    }
}

#Preview {
    RegistrationView()
}
