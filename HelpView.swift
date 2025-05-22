import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Need Help?")
                    .font(.largeTitle)
                    .bold()

                Text("If you're feeling stuck or something isn’t working quite right, check the following:")
                Text("• Restart the app\n• Check your internet connection\n• Make sure your iOS is up to date")

                Text("Still need help? Reach out to us at support@focusbubble.app 💌")
                    .padding(.top)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Help")
    }
}
