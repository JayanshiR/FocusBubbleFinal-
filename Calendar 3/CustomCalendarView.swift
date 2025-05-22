import SwiftUI
import EventKit
import UserNotifications

struct CustomCalendarView: View {
    @State private var currentDate = Date()
    @State private var selectedDate = Date()
    @State private var showEventForm = false
    @State private var events: [EventModel] = []

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: { changeMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }

                Spacer()

                Text(getMonthYear(from: currentDate))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()

                Button(action: { changeMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
            }
            .padding(.horizontal)

            // Weekday header
            let weekdays = Calendar.current.shortWeekdaySymbols
            HStack {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            // Dates Grid
            let days = getDatesForMonth(currentDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                ForEach(days, id: \.self) { date in
                    if date != Date.distantPast {
                        Button(action: {
                            selectedDate = date
                            showEventForm = true
                        }) {
                            Text("\(Calendar.current.component(.day, from: date))")
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(backgroundColor(for: date))
                                .foregroundColor(foregroundColor(for: date))
                                .clipShape(Circle())
                                .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: 1)
                        }
                        .animation(.easeInOut(duration: 0.2), value: selectedDate)
                    } else {
                        Text("")
                            .frame(height: 40)
                    }
                }
            }

            Spacer()
        }
        .padding(.top)
        .sheet(isPresented: $showEventForm) {
            AddReminder(selectedDate: selectedDate) { newEvent in
                events.append(newEvent)
            }
        }
    }

    // MARK: - Helpers

    func getMonthYear(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }

    func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }

    func getDatesForMonth(_ date: Date) -> [Date] {
        var calendar = Calendar.current
        calendar.firstWeekday = 1

        let range = calendar.range(of: .day, in: .month, for: date)!
        let components = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: components)!

        let weekday = calendar.component(.weekday, from: startOfMonth)
        var days: [Date] = Array(repeating: Date.distantPast, count: weekday - 1)

        for day in range {
            if let fullDate = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(fullDate)
            }
        }

        return days
    }

    func isSameDay(date1: Date, date2: Date) -> Bool {
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }

    func backgroundColor(for date: Date) -> Color {
        if isSameDay(date1: selectedDate, date2: date) {
            return Color.blue.opacity(0.2)
        } else if isSameDay(date1: date, date2: Date()) {
            return Color.yellow.opacity(0.2)
        } else {
            return Color.clear
        }
    }

    func foregroundColor(for date: Date) -> Color {
        if isSameDay(date1: selectedDate, date2: date) {
            return .blue
        } else {
            return .primary
        }
    }
}
