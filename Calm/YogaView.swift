import SwiftUI

struct YogaView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Yoga")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Rectangle()
                        .fill(Color.white.opacity(0.1))
                        .frame(height: 250)
                        .cornerRadius(20)
                        .overlay(
                            VStack {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                                Text("Yoga Session Placeholder")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        )

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Yoga")
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
    YogaView()
}
