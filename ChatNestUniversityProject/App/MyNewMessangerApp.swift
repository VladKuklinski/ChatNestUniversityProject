//
//  MyNewMessangerApp.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 31/07/2025.
//

import SwiftUI
import FirebaseCore
import FacebookCore


class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
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
