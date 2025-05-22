import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    SettingItem(title: "Help", icon: "questionmark.circle.fill", color: .blue)
                    SettingItem(title: "Privacy", icon: "lock.shield.fill", color: .purple)
                    SettingItem(title: "Theme", icon: "paintbrush.fill", color: .orange)
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Settings")
        }
    }
}

struct SettingItem: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .padding(12)
                .background(color.opacity(0.8))
                .clipShape(Circle())

            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.9))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    SettingsView()
}
