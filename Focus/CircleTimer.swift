import SwiftUI

struct CircleTimer: View {
    var fraction: Double
    var primaryText: String
    var secondaryText: String

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
            Circle()
                .trim(from: 0.0, to: CGFloat(fraction))
                .stroke(Color.red, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
            VStack {
                Text(primaryText)
                    .font(.largeTitle)
                    .bold()
                Text(secondaryText)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding(40)
    }
}

#Preview {
    CircleTimer(fraction: 0.3, primaryText: "10:00", secondaryText: "Work")
}
