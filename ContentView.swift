import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("Focus Bubble")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                // 🟢 Navigate to HomePage instead of FocusView
                NavigationLink(destination: HomePage()) {
                    Text("Start")
                        .font(.title2)
                        .padding()
                        .frame(width: 200)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
