import EventKit
import UserNotifications

class CalendarManager {
    let eventStore = EKEventStore()

    // Request calendar access
    func requestAccess(completion: @escaping (Bool) -> Void) {
        print("🔐 Requesting calendar access...")

        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToEvents { granted, error in
                DispatchQueue.main.async {
                    if granted && error == nil {
                        print("✅ Calendar access granted (iOS 17+)")
                        completion(true)
                    } else {
                        print("❌ Calendar access denied: \(error?.localizedDescription ?? "Unknown error")")
                        completion(false)
                    }
                }
            }
        } else {
            eventStore.requestAccess(to: .event) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        print("✅ Calendar access granted")
                    } else {
                        print("❌ Calendar access denied: \(error?.localizedDescription ?? "Unknown error")")
                    }
                    completion(granted)
                }
            }
        }
    }

    // Add an event and schedule a local notification
    func addReminder(
        title: String,
        location: String? = nil,
        startDate: Date,
        travelBuffer: TimeInterval = 15 * 60
    ) {
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = startDate.addingTimeInterval(60 * 60)
        event.calendar = eventStore.defaultCalendarForNewEvents

        let leaveTime = startDate.addingTimeInterval(-travelBuffer)
        event.notes = "Leave by \(formattedTime(leaveTime)) to arrive on time."

        if let loc = location {
            event.location = loc
        }

        do {
            try eventStore.save(event, span: .thisEvent)
            print("✅ Event saved: \(event.title ?? "Untitled") at \(formattedTime(startDate))")

            if leaveTime > Date() {
                scheduleNotification(
                    title: "Get ready: \(title)",
                    body: event.notes ?? "",
                    at: leaveTime
                )
            } else {
                print("⚠️ Skipping notification – leave time is in the past")
            }
        } catch {
            print("❌ Error saving event: \(error.localizedDescription)")
        }
    }

    // Time formatting
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    // Schedule a notification
    private func scheduleNotification(title: String, body: String, at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: date
        )

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification error: \(error.localizedDescription)")
            } else {
                print("🔔 Notification scheduled for \(self.formattedTime(date))")
            }
        }
    }

    // Optional: list events for debugging
    func listUpcomingEvents() {
        let calendars = eventStore.calendars(for: .event)
        let oneMonth = Date().addingTimeInterval(30 * 24 * 60 * 60)
        let predicate = eventStore.predicateForEvents(withStart: Date(), end: oneMonth, calendars: calendars)
        let events = eventStore.events(matching: predicate)

        for event in events {
            let title = event.title ?? "Untitled"
            let date = event.startDate != nil ? formattedTime(event.startDate!) : "Unknown time"
            print("📅 \(title) at \(date)")
        }
    }
}
