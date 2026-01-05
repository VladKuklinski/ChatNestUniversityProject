//
//  NewMessageView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI
import FirebaseAuth

struct NewMessageView: View {
    @StateObject var viewModel : NewMessageViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var selectedUser : User?
    var user : User
    @EnvironmentObject var friendStore :  FriendsStore
    
    init(selectedUser: Binding<User?>,
         user : User,
         userService: UserServiceProtocol = UserService.shared,
         friendService: FriendListServiceProtocol = FriendListService.shared,
         friendRequestService : FriendRequestService = FriendRequestService(),
         friendStore :  FriendsStore
         
    ) {
        self._selectedUser = selectedUser
        self.user = user
        _viewModel = StateObject(wrappedValue: NewMessageViewModel(
            userService: userService, friendStore: friendStore
        ))
    }
    var currentUser = Auth.auth().currentUser?.uid
    var body: some View {
        NavigationStack {
            ScrollView {
                TextField("To:", text: $viewModel.searchText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGroupedBackground))
                LazyVStack {
                    Text("CONTACTS:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 15)
                    ForEach(viewModel.sortedUsers) { oneUser in
                        HStack {
                            HStack {
                                AvatarView(tempImage: nil,
                                           imageUrl: oneUser.imageUrl,
                                           size: .small)
                                Text(oneUser.fullName)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedUser = oneUser
                                dismiss()
                            }
                            Spacer()
                            HStack {
                                if friendStore.isFriend(otherUser: oneUser) {
                                    Button {
                                        Task {
                                            try await friendStore.unfriend(oneUser)
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: "person.fill.checkmark")
                                                .foregroundColor(.green)
                                            Text("Friends")
                                                .font(.footnote)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                } else if friendStore.hasSentRequest(to: oneUser) {
                                    HStack {
                                        Image(systemName: "person.fill.checkmark")
                                            .foregroundColor(.gray)
                                        Text("Request sent")
                                            .font(.footnote)
                                            .foregroundColor(.primary)
                                    }
                                    .onTapGesture {
                                        Task {
                                           try await friendStore.cancelRequest(to: oneUser)
                                        }
                                    }
                                } else if
                                          friendStore.hasIncomingRequest(from: oneUser) {
                                    HStack {
                                        HStack {
                                            Image(systemName: "person.crop.circle.badge.plus")
                                                .foregroundColor(.blue)
                                            Text("Accept")
                                                .foregroundColor(.primary)
                                        }
                                        .onTapGesture {
                                            Task {
                                               try await friendStore.acceptRequest(from: oneUser)
                                            }
                                        }
                                        HStack {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                            Text("Decline")
                                                .foregroundColor(.primary)
                                        }
                                        .onTapGesture {
                                            Task {
                                                try await friendStore.declineRequest(from: oneUser)
                                            }
                                        }
                                    }
                                } else {
                                    HStack {
                                        Image(systemName: "person.fill.badge.plus")
                                            .foregroundStyle(.blue)
                                        Text("Add friend")
                                            .foregroundColor(.primary)
                                    }
                                    .onTapGesture {
                                        Task {
                                            try await friendStore.sendRequest(to: oneUser)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .navigationTitle("New Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            Task {
                try await friendStore.fetchAllRequests()
                try await friendStore.fetchFriends()
            }
        }
    }
}


