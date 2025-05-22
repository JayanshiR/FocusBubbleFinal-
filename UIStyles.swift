import SwiftUI

struct RoundedItem: View {
    var icon: String
    var text: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(12)
                .background(Color("PrimaryBlue"))
                .clipShape(Circle())

            Text(text)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

