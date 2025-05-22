import SwiftUI

struct CalmUITestView: View {
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("🧘‍♀️ Calm UI Test")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .padding(.top)

                // Sample Button
                Button(action: {}) {
                    Label("Start Focus Session", systemImage: "timer")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Another Button
                Button(action: {}) {
                    Label("Add Reminder", systemImage: "plus.circle.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Sample Date Picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pick a Time")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    DatePicker("", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Info Card
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.purple.opacity(0.1))
                    .frame(height: 120)
                    .overlay(
                        VStack(spacing: 8) {
                            Text("✨ Tip for Today")
                                .font(.headline)
                            Text("Break tasks into small wins and reward yourself.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding()
                    )
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Calm UI Preview")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CalmUITestView()
}
