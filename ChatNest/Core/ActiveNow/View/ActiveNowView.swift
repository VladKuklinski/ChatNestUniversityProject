//
//  ActiveNowCell.swift
//  MyNewMessanger
//
//  Created by Vlad Kuklinski on 01/08/2025.
//

import SwiftUI

struct ActiveNowView: View {
    let user : User
    @StateObject var viewModel : ActiveNowViewModel
    
    init(user : User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ActiveNowViewModel(
            user: user,
            manager: ActivityStatusManager()))
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarView(tempImage: nil,
                       imageUrl: user.imageUrl,
                       size: .large)
            ZStack {
                Circle()
                    .foregroundStyle(.white)
                    .frame(height: 18)
                Circle()
                    .foregroundStyle(viewModel.color)
                    .frame(height: 14)
            }
        }
    }
}

#Preview {
    ActiveNowView(user: .mockUser)
}
