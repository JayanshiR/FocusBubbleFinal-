import Foundation

struct EventModel: Identifiable {
    let id = UUID()
    let title: String
    let eventTime: Date
    let getReadyBuffer: TimeInterval
}
