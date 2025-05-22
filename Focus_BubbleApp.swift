import SwiftUI
import UserNotifications

@main
struct Focus_BubbleApp: App {
    
    init() {
        // Request notification permission once at app launch
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("🔔 Notifications allowed.")
            } else {
                print("❌ Notification permission not granted.")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            HomePage() // replace with your actual main view if different
        }
    }
}
