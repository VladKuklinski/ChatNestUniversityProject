//
//  MyNewMessangerApp.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 31/07/2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct MyNewMessangerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var profileViewModel  = ProfileViewModel(userService: UserService.shared,
                                                          authService: AuthService.shared)
    @StateObject var contentViewModel  = ContentViewModel()
    @StateObject var friendsStore =  FriendsStore(friendService: FriendListService(),
                                                  friendRequestService: FriendRequestService())

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(profileViewModel)
                .environmentObject(contentViewModel)
                .environmentObject(friendsStore)

        }
    }
}
