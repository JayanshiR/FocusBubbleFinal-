import SwiftUI

struct NotificationsDisabled: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Notifications are disabled.")
                .font(.headline)
                .foregroundColor(.red)

            Text("Please enable them in Settings to receive Pomodoro alerts and reminders.")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Button(action: {
                openSettings()
            }) {
                Text("Open Settings")
                    .font(.body)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    // 📱 Opens app settings
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
#Preview {
    NotificationsDisabled()
}





