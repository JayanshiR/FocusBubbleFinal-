import SwiftUI

struct MeditationView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // Original content placeholder
                Color.blue.opacity(0.1).ignoresSafeArea()
                Text("MeditationView content goes here")
            }
            .navigationTitle("Meditation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HomePage()) {
                        Image(systemName: "house")
                    }
                }
            }
        }
    }
}

#Preview {
    MeditationView()
}
