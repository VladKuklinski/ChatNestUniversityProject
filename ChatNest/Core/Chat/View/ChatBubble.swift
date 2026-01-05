//
//  ChatBubble.swift
//  Messenger2
//
//  Created by Vlad Kuklinski on 23/07/2025.
//


import SwiftUI

struct ChatBubble: Shape {
    let FromCurrentUser : Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                     byRoundingCorners: [
                        .topLeft,
                        .topRight,
                        FromCurrentUser ? .bottomLeft : .bottomRight
                     ],
                     cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBubble(FromCurrentUser: true)
}
