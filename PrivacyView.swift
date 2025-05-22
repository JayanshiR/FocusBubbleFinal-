import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Privacy Policy")
                    .font(.largeTitle)
                    .bold()

                Text("We value your privacy deeply. Here's how we handle your data:")

                Text("• We only collect data you enter — like reminders, moods, and preferences.\n• Your data stays on your device unless you choose to sync it.\n• No ads. No tracking. Ever.")

                Text("You can delete your data anytime from the app settings.")
                    .padding(.top)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Privacy")
    }
}
