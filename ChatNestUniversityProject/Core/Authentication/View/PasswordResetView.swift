//
//  PasswordResetView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 05/09/2025.
//

import SwiftUI

struct PasswordResetView: View {
    @StateObject var viewModel = PasswordResetViewModel(authService: AuthService(
                                                                    activityManager: ActivityStatusManager(),
                                                                    userService: UserService.shared),
                                                                    emailValidator: EmailValidator())
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 30)
                TextField("Write your email", text: $viewModel.email)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 5)
                Spacer()
                    .frame(height: 20)
                Button {
                    Task {
                        await viewModel.resetPassword()
                        if viewModel.message != nil {
                            showAlert.toggle()
                        }
                    }
                } label: {
                    Text("Send password reset link")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(.vertical, 10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
            }
            .padding(.horizontal, 17)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Reset your password")
            .navigationBarTitleDisplayMode(.large)
            .alert("Password reset", isPresented: $showAlert, presenting: viewModel.message) { _ in
                if viewModel.sentWithSuccess {
                    Button("OK") {
                        dismiss()
                    }
                } else {
                    Button("OK", role: .cancel) {}
                }
            } message: { message in
                Text(message)
            }
        }
    }
}

#Preview {
    PasswordResetView()
}
