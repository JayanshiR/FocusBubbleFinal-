import SwiftUI

struct AddReminder: View {
    var selectedDate: Date
    var onSave: (EventModel) -> Void

    @State private var title = ""
    @State private var location = ""
    @State private var travelBuffer: Double = 15
    @State private var selectedTime = Date()

    @Environment(\.dismiss) var dismiss

    let calendarManager = CalendarManager()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reminder Details")) {
                    TextField("Title", text: $title)
                    TextField("Location (optional)", text: $location)

                    DatePicker("Time", selection: $selectedTime, in: dateRange, displayedComponents: [.hourAndMinute])

                    Stepper(value: $travelBuffer, in: 0...60, step: 5) {
                        Text("Get ready reminder: \(Int(travelBuffer)) min before")
                    }
                }

                Button(action: {
                    calendarManager.requestAccess { granted in
                        if granted {
                            let fullDate = merge(date: selectedDate, time: selectedTime)

                            let event = EventModel(
                                title: title,
                                eventTime: fullDate,
                                getReadyBuffer: travelBuffer * 60
                            )

                            calendarManager.addReminder(
                                title: event.title,
                                location: location.isEmpty ? nil : location,
                                startDate: event.eventTime,
                                travelBuffer: event.getReadyBuffer
                            )

                            onSave(event)
                            dismiss()
                        } else {
                            print("❌ Calendar access denied")
                        }
                    }
                }) {
                    Label("Add Reminder", systemImage: "plus.circle.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(title.isEmpty)
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
        .onAppear {
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: Date())
            let currentMinute = calendar.component(.minute, from: Date())

            var components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
            components.hour = currentHour
            components.minute = currentMinute + 10

            selectedTime = calendar.date(from: components) ?? selectedDate
        }
    }

    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
            .addingTimeInterval(-1)
        return startOfDay...endOfDay
    }

    func merge(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)

        var merged = DateComponents()
        merged.year = dateComponents.year
        merged.month = dateComponents.month
        merged.day = dateComponents.day
        merged.hour = timeComponents.hour
        merged.minute = timeComponents.minute

        return calendar.date(from: merged) ?? date
    }
}
