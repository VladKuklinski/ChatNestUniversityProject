//
//  ChatMessageCell.swift
//  Messenger2
//
//  Created by Vlad Kuklinski on 23/07/2025.
//

import SwiftUI

struct ChatMessageCell: View {
    let message : Message
    var isFromCurrentUser : Bool {
        return message.fromCurrentUser
    }
    var body: some View {
        if isFromCurrentUser {
            HStack {
                Spacer()
                Text(message.messageText)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(ChatBubble(FromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.maxX / 1.5, alignment: .trailing)
            }
        } else {
            HStack(alignment: .bottom) {
                
                AvatarView(tempImage: nil,
                           imageUrl: message.user?.imageUrl,
                           size: .xsmall)
                Text(message.messageText)
                    .foregroundStyle(.black)
                    .padding()
                    .background(Color(.systemGray5))
                    .clipShape(ChatBubble(FromCurrentUser: isFromCurrentUser))
                    .frame(maxWidth: UIScreen.main.bounds.maxX / 1.6, alignment: .leading)
                Spacer()
            }
        }
    }
}

