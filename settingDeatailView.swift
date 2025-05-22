import SwiftUI

struct SettingsDetailView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Help") {
                // Action for Help
                print("Help tapped")
            }
            .buttonStyle(DefaultButton())

            Button("Privacy") {
                // Action for Privacy
                print("Privacy tapped")
            }
            .buttonStyle(DefaultButton())

            Button("Theme") {
                // Action for Theme
                print("Theme tapped")
            }
            .buttonStyle(DefaultButton())
        }
        .padding()
        .navigationTitle("More Settings")
    }
}

struct DefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(configuration.isPressed ? 0.5 : 0.2))
            .cornerRadius(12)
            .foregroundColor(.primary)
    }
}
