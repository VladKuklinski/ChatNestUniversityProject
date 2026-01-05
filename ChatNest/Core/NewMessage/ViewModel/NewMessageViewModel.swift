//
//  NewMessageViewModel.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 04/08/2025.
//

import Foundation
import FirebaseAuth
import SwiftUI

class NewMessageViewModel : ObservableObject {
    
    private let userService : UserServiceProtocol
    var friendStore : FriendsStore
    @Published var friendIcon : String?
    @Published var friendText : String?
    @Published var iconColor : Color?
    @Published var users : [User] = []
    @Published var searchText : String = ""
    
    var sortedUsers : [User] {
        let filtered = users.filter { user in
            guard !searchText.isEmpty else { return true }
            let lowercasedSearch = searchText.lowercased()
            return user.fullName.lowercased().contains(lowercasedSearch)
        }
        return filtered.sorted {
            let lhsIsFriend = friendStore.isFriend(otherUser: $0)
            let rhsIsFriend = friendStore.isFriend(otherUser: $1)
            if lhsIsFriend != rhsIsFriend {
                return lhsIsFriend && !rhsIsFriend
            } else {
                return $0.fullName < $1.fullName
            }
        }
    }
    init(userService : UserServiceProtocol,
         friendStore : FriendsStore
    ) {
        self.userService = userService
        self.friendStore = friendStore

        Task {
            try await loadingAllUsers()
        }
    }
    
    @MainActor
    private func loadingAllUsers() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else {return}
        let users = try await userService.fetchAllUsers()
        self.users = users.filter({$0.id != currentUid})
        print("users fetched and filtered")
    }
}

