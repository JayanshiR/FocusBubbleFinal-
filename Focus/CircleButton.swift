import SwiftUI

struct CircleButton: View {
    var icon: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Circle().fill(Color.blue))
        }
    }
}

#Preview {
    CircleButton(icon: "play.fill", action: {})
}
