import SwiftUI

struct FocusView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Focus")
                    .font(.largeTitle)
                    .padding(.bottom, 40)

                NavigationLink(destination: PomodoroView()) {
                    Text("Pomodoro")
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.headline)
                }

               
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    FocusView()
}
