//
//  InboxViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class InboxViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var recentMessages: [Message] = []
    @Published var users : [User] = []
    
    var friendStore : FriendsStore
    var sortedFriends: [User] {
        users.filter { isFriend($0) }
            .sorted {
                if $0.isActive != $1.isActive {
                    return $0.isActive && !$1.isActive
                } else {
                    return $0.fullName < $1.fullName
                }
            }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let observingMessagesService : ObservingMessageServiceProtocol
    private let userService : UserServiceProtocol
    private let authService : FirebaseAuthServiceProtocol
    
    init(
        observingMessagesService : ObservingMessageServiceProtocol,
        userService : UserServiceProtocol = UserService.shared,
        authService : FirebaseAuthServiceProtocol = FirebaseAuthService(),
        friendStore : FriendsStore
    ) {
        self.userService = userService
        self.observingMessagesService = observingMessagesService
        self.authService = authService
        self.friendStore = friendStore
        Task {
            try? await userService.fetchUserData(uid: nil)
            setupSubscribers()
            loadRecentMessages()
            try await filterActiveUsers()
            try await friendStore.fetchFriends()
            try await friendStore.fetchAllRequests()
        }
    }
    @MainActor
    func filterActiveUsers() async throws {
        guard let currentUid = authService.currentUserUid else {return}
        let fetchedUsers = try await userService.fetchAllUsers()
        let users = fetchedUsers
            .filter{$0.uid != currentUid}
        self.users = users
        print("online users filtered and sorted")
    }
    private func setupSubscribers() {
        userService.currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userFromUserService in
                self?.currentUser = userFromUserService
                print("DEBUG: currentUser updated -> \(userFromUserService?.fullName ?? "nil")")
            }
            .store(in: &cancellables)
    }
    func loadRecentMessages() {
        observingMessagesService.observeRecentMessages { [weak self] messages in
            self?.recentMessages = messages
        }
    }
    func isFriend(_ otherUser : User) -> Bool {
        return friendStore.friends.contains(where: { $0.uid == otherUser.uid })
    }
}

