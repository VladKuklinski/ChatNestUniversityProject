//
//  InboxView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI

struct InboxView: View {
    @StateObject var viewModel : InboxViewModel
    
    @EnvironmentObject var profileViewModel : ProfileViewModel
    @EnvironmentObject var friendsStore : FriendsStore
    @State var showNewMessageScreen = false
    @State var showProfileView = false
    @State var selectedUser : User?
    private var activityManager = ActivityStatusManager()
    
    init(
        friendService: FriendListServiceProtocol = FriendListService.shared,
        friendRequestService : FriendRequestService = FriendRequestService(),
        observingMessagesService: ObservingMessageServiceProtocol = ObservingMessageService(),
        friendStore : FriendsStore
    ) {
        _viewModel = StateObject(wrappedValue: InboxViewModel(
            observingMessagesService: observingMessagesService, friendStore: friendStore))
    }
    var user : User? {
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.sortedFriends) { otherUser in
                                ActiveNowView(user: otherUser)
                                    .onTapGesture {
                                        selectedUser = otherUser
                                    }
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .scrollIndicators(.hidden)
                    Divider()
                        .padding(.bottom, 8)
                    LazyVStack {
                        if !viewModel.recentMessages.isEmpty {
                            ForEach(viewModel.recentMessages) { message in
                                Button {
                                    if let chatUser = message.user {
                                        selectedUser = chatUser
                                    }
                                } label: {
                                    MessageCell(user: message.user ?? User.mockUser, message: message)
                                }
                                .buttonStyle(.plain)
                            }
                        } else {
                            VStack {
                                Text("No chats yet")
                                    .fontWeight(.semibold)
                                    .font(.largeTitle)
                                    .padding(.vertical)
                                Text("Start chating with your friends")
                                    .font(.headline)
                                HStack {
                                    Text("Click")
                                    Image(systemName: "square.and.pencil")
                                        .resizable()
                                        .foregroundStyle(Color(.black))
                                        .frame(width: 25, height: 25)
                                    Text("in the right corner")
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 9)
                }
            }
            .navigationDestination(item: $selectedUser, destination: { notNilUser in
                ChatView(user: notNilUser)
            })
            .fullScreenCover(isPresented: $showNewMessageScreen, content: {
                if let user {
                    NewMessageView(selectedUser: $selectedUser,
                                   user: user, friendStore: friendsStore)
                    .environmentObject(friendsStore)
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if let user {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            AvatarView(tempImage: profileViewModel.tempImage,
                                       imageUrl: profileViewModel.user?.imageUrl,
                                       size: .xsmall)
                            .accessibilityIdentifier("myImageID")
                        }
                    } else {
                        ProgressView()
                    }
                }
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("ChatNest")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showNewMessageScreen = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .foregroundStyle(Color(.black))
                            .frame(width: 25, height: 25)
                    }
                }
            }
        }
    }
}
