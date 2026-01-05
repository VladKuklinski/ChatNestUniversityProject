//
//  EditDataView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 08/09/2025.
//

import SwiftUI
import FirebaseAuth

struct EditDataView: View {
    
    @StateObject var viewModel = EditDataViewModel(userService: UserService.shared,
                                                   authService: AuthService.shared)
    @Binding var user : User?
    @State var showEmailChange = false
    @State var showPasswordChange = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("", text: Binding(
                        get: { user?.fullName ?? "" },
                        set: { user?.fullName = $0}))
                    .padding(.vertical, 5)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                if let email = Auth.auth().currentUser?.email {
                    Section {
                        Button {
                            showEmailChange.toggle()
                        } label: {
                            HStack {
                                Text("Change email")
                                    .foregroundStyle(.black)
                                Spacer()
                                Text(email)
                                    .lineLimit(1)
                                    .foregroundStyle(Color(.systemGray))
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }
                        Button {
                            showPasswordChange.toggle()
                        } label: {
                            HStack {
                                Text("Reset password")
                                    .foregroundStyle(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(Color(.systemGray))
                            }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showEmailChange, content: {
                ChangeEmailView()
            })
            .fullScreenCover(isPresented: $showPasswordChange, content: {
                PasswordResetView()
            })
            .navigationTitle("Edit your data")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save data") {
                        Task {
                            try await viewModel.changeName(newName: user?.fullName ?? "")
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    EditDataView(user: .constant(.mockUser))
}
