import SwiftUI

struct MessageCell: View {
    let user: User
    let message: Message   

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(tempImage: nil,
                       imageUrl: user.imageUrl,
                       size: .small)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullName)
                    .font(.headline)

                Text(message.messageText)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            Spacer()
            Text(message.timestamp.dateValue(), style: .time)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    MessageCell(user: .mockUser,
                message: .mockMessage)
}
