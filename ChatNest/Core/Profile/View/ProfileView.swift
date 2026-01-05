//
//  ProfileView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct ProfileView: View {
    let user : User
    @EnvironmentObject var viewModel : ProfileViewModel
    @State var showDeleteAlert = false
    @State var showErrorAlert = false
    @State var showLogOutAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                    .frame(height: 20)
                PhotosPicker(selection: $viewModel.selectedImage) {
                    ZStack(alignment: .bottomTrailing) {
                        AvatarView(tempImage: viewModel.tempImage,
                                   imageUrl: viewModel.user?.imageUrl,
                                   size: .xlarge)
                        ZStack {
                            Circle()
                                .foregroundStyle(Color(.systemGray4))
                                .frame(height: 25)
                                .padding(3)
                            Image(systemName: "camera.fill")
                                .foregroundStyle(.black)
                                .font(.system(size: 14))
                        }
                    }
                }
                Text(user.fullName)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            List {
                Section {
                    ForEach(ProfileSettings.allCases, id: \.self) { element in
                        HStack {
                            Image(systemName: element.image)
                                .foregroundStyle(element.backGroundColor)
                                .font(.title)
                            Text(element.title)
                                .font(.title3)
                                .padding(.horizontal, 5)
                        }
                    }
                }
                Section {
                    Button("Log out", role: .destructive) {
                        showLogOutAlert.toggle()
                    }
                    Button("Delete account", role: .destructive) {
                        showDeleteAlert.toggle()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        EditDataView(user: $viewModel.user)
                    } label: {
                        Text("Edit data")
                    }
                }
            }
            .alert("Loging out", isPresented: $showLogOutAlert) {
                Button("Log out", role: .destructive) {
                    Task {
                        await viewModel.signOut()
                    }
                }
            } message: {
                Text(Constants.logoutText)
            }
            .alert("Deleting an account", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    Task {
                        await viewModel.deleteAccount()
                    }
                }
            } message: {
                Text(Constants.deleteText)
            }
            
            .alert("Error", isPresented: $viewModel.showErrorAlert, presenting: viewModel.errorAlertMessage) {_ in
                Button("OK", role: .cancel) {}
            } message: { message in
                Text(message)
            }
        }
    }
}

#Preview {
    ProfileView(user: .mockUser)
        .environmentObject(ProfileViewModel(userService: UserService.shared, authService: AuthService.shared))
}

