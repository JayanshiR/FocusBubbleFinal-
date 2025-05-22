import SwiftUI

struct BreathingView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                // Your original content here
                Text("Breathing exercises go here!")
            }
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
