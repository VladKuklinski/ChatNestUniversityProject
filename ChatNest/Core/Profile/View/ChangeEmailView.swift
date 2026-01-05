//
//  PasswordResetView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 05/09/2025.
//

import SwiftUI

struct ChangeEmailView: View {
    @StateObject var viewModel = EditDataViewModel(userService: UserService.shared,
                                                   authService: AuthService.shared)
    @State var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 30)
                TextField("Write new email", text: $viewModel.email)
                    .padding(12)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical, 5)
                Spacer()
                    .frame(height: 20)
                Button {
                    Task {
                        try await viewModel.changeEmail(to: viewModel.email)
                        if viewModel.message != nil {
                            showAlert.toggle()
                        }
                    }
                } label: {
                    Text("Send link to new email")
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
            .navigationTitle("Change your email")
            .navigationBarTitleDisplayMode(.large)
            .alert("Changing email", isPresented: $showAlert, presenting: viewModel.message) { _ in
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
    ChangeEmailView()
}
