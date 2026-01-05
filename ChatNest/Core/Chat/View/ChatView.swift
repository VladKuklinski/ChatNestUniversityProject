//
//  ChatView.swift
//  Messenger2
//
//  Created by Vlad Kuklinski on 23/07/2025.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel : ChatViewModel
    @State var message = ""
    let user : User
    
    init(user : User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: ChatViewModel(user: user,
                                                                  sendingMessageService: SendingMessageService(),
                                                                  observingMessageService: ObservingMessageService()))
    }
    var body: some View {
        VStack {
            ScrollView {
                AvatarView(tempImage: nil,
                           imageUrl: user.imageUrl,
                           size: .medium)
                Text(user.fullName)
                    .font(.headline)
                Text("Messenger")
                    .foregroundStyle(Color(.systemGray2))
                    .font(.footnote)
                ForEach(viewModel.messages) { message in
                    LazyVStack {
                        ChatMessageCell(message: message)
                    }
                }
            }
            .padding(.horizontal, 6)
            Spacer()
            ZStack(alignment: .trailing) {
                TextField("Aa", text: $viewModel.textMessage, axis: .vertical)
                    .padding(12)
                    .padding(.trailing, 48)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                Button {
                    viewModel.sendMessage()
                    viewModel.textMessage = ""
                } label: {
                    Text("Send")
                        .fontWeight(.semibold)
                }
                .padding(15)

            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    ChatView(user: .mockUser)
}
