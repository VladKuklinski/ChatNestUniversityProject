//
//  FriendStore.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 23/09/2025.
//


import Combine
import FirebaseAuth
import SwiftUI

final class FriendsStore: ObservableObject {
    
    @Published var friends: [User] = []
    @Published var outgoingRequests: [User] = []
    @Published var incomingRequests: [User] = []
    private let friendService: FriendListServiceProtocol
    private let friendRequestService: FriendRequestServiceProtocol
    
    init(friendService: FriendListServiceProtocol = FriendListService.shared,
         friendRequestService: FriendRequestServiceProtocol
         ) {
        self.friendService = friendService
        self.friendRequestService = friendRequestService
    }
    @MainActor
    func fetchFriends() async throws{
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        do {
            friends = try await friendService.fetchFriends(for: currentUserUID)
            print("DEBUG: Friends were fetched")
        } catch {
            print("DEBUG: Error fetching friends - \(error.localizedDescription)")
        }
    }
    @MainActor
    func fetchAllRequests() async throws{
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        do {
            outgoingRequests = try await friendService.fetchSentRequest(for: currentUid)
            incomingRequests = try await friendService.fetchIncomingRequest(for: currentUid)
            print("DEBUG: Outgoing and incoming requests were fetched")
        } catch {
            print("DEBUG: Error fetching requests - \(error.localizedDescription)")
        }
    }
    @MainActor
    func declineRequest(from otherUser : User) async throws {
        incomingRequests.removeAll{$0.uid  == otherUser.uid}
        do {
            guard let currentUserUID = Auth.auth().currentUser?.uid,
            let otherUserUID = otherUser.uid else {return}
            try await friendRequestService.declineRequest(userUID: currentUserUID, friendUID: otherUserUID)
            print("DEBUG : Friend request was declined")
        } catch {
            incomingRequests.append(otherUser)
            print("DEBUG : Unable to decline a request - \(error.localizedDescription)")
        }
    }
    @MainActor
    func sendRequest(to otherUser : User) async throws {
        self.outgoingRequests.append(otherUser)
        do {
            guard let currentUserUID = Auth.auth().currentUser?.uid,
                  let otherUserUID = otherUser.uid else {return}
            try await friendRequestService.sendRequest(from: currentUserUID, to: otherUserUID)
            print("DEBUG : Friend request was sent")
        } catch {
            outgoingRequests.removeAll {$0.uid == otherUser.uid}
            print("DEBUG : Unable to send a friend request - \(error.localizedDescription)")
        }
    }
    @MainActor
    func cancelRequest(to otherUser : User) async throws {
        self.outgoingRequests.removeAll{$0.uid == otherUser.uid}
        do {
            guard let currentUserUID = Auth.auth().currentUser?.uid,
                  let otherUserUID = otherUser.uid else {return}
            try await friendRequestService.cancelRequest(userUID: currentUserUID, friendUID: otherUserUID)
            print("DEBUG : Friend request was cancelled")
        } catch {
            outgoingRequests.append(otherUser)
            print("DEBUG : Unable to send a friend request - \(error.localizedDescription)")
        }
    }
    @MainActor
    func acceptRequest(from otherUser : User) async throws {
        friends.append(otherUser)
        do {
            guard let currentUserUID = Auth.auth().currentUser?.uid,
            let otherUserUID = otherUser.uid else {return}
            try await friendRequestService.acceptRequest(userUID: currentUserUID, friendUID: otherUserUID)
            print("DEBUG : Friend request was accepted")
        } catch {
            friends.removeAll{$0.uid == otherUser.uid}
            print("DEBUG : Unable to accept a friend request - \(error.localizedDescription)")
        }
    }
    @MainActor
    func unfriend(_ otherUser : User) async throws {
        friends.removeAll{$0.uid == otherUser.uid}
        do {
            guard let currentUserUID = Auth.auth().currentUser?.uid,
            let otherUserUID = otherUser.uid else {return}
            try await friendRequestService.unfriend(userUID: currentUserUID, friendUID: otherUserUID)
            print("DEBUG : Unfriend a user successfully)")
        } catch {
            friends.append(otherUser)
            print("DEBUG : Unable to unfriend a user - \(error.localizedDescription)")
        }
    }
    func isFriend(otherUser : User) -> Bool {
        return friends.contains(otherUser)
    }
    func hasSentRequest(to uid: User) -> Bool {
        outgoingRequests.contains(uid)
    }
    func hasIncomingRequest(from uid: User) -> Bool {
        incomingRequests.contains(uid)
    }
    
}

