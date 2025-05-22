import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Text("Focus Bubble")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(.top)

                VStack(spacing: 20) {
                    NavigationLink(destination: CalmPage()) {
                        RoundedItem(icon: "leaf.fill", text: "Calm")
                    }

                    NavigationLink(destination: CustomCalendarView()) {
                        RoundedItem(icon: "calendar.badge.clock", text: "My Reminders")
                    }

                    NavigationLink(destination: PomodoroView()) {
                        RoundedItem(icon: "timer", text: "Pomodoro")
                    }
                }

                Spacer()
            }
            .padding()
            .background(Color("LightBlueBG").ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}
