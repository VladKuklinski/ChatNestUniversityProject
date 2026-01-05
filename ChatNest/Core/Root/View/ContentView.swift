//
//  ContentView.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 31/07/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : ContentViewModel
    @EnvironmentObject var friendStore : FriendsStore


    
    var body: some View {
        Group {
            if viewModel.currentUser != nil {
                InboxView(friendStore: friendStore)
                
             } else {
                LoginView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
