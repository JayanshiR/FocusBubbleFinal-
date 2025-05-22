import Foundation
import Combine

class PomodoroTimer: ObservableObject {
    enum TimerMode: String {
        case work = "Focus Time"
        case pause = "Break Time"
    }

    enum TimerState {
        case idle, running, paused
    }

    @Published var secondsLeft: Int = 0
    @Published var mode: TimerMode = .work
    @Published var state: TimerState = .idle

    var workInSeconds: Int
    var breakInSeconds: Int
    private var totalTime: Int = 0

    private var timer: AnyCancellable?
    var onSessionEnd: (() -> Void)? // 🔔 Triggered when timer ends

    init(workInSeconds: Int = 1500, breakInSeconds: Int = 300) {
        self.workInSeconds = workInSeconds
        self.breakInSeconds = breakInSeconds
        self.secondsLeft = workInSeconds
        self.totalTime = workInSeconds
    }

    var fractionPassed: Double {
        guard totalTime > 0 else { return 0 }
        return 1 - (Double(secondsLeft) / Double(totalTime))
    }

    var secondsLeftString: String {
        let minutes = secondsLeft / 60
        let seconds = secondsLeft % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func start() {
        guard state != .running else { return }

        state = .running
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.tick()
            }
    }

    func pause() {
        state = .paused
        timer?.cancel()
    }

    func reset() {
        timer?.cancel()
        state = .idle
        if mode == .work {
            secondsLeft = workInSeconds
            totalTime = workInSeconds
        } else {
            secondsLeft = breakInSeconds
            totalTime = breakInSeconds
        }
    }

    func skip() {
        switchMode()
        reset()
        start()
    }

    func updateDurations(work: Int, breakTime: Int) {
        self.workInSeconds = work
        self.breakInSeconds = breakTime
        reset()
    }

    private func tick() {
        if secondsLeft > 0 {
            secondsLeft -= 1
        } else {
            onSessionEnd?() // 🔔 Play sound when time is up
            switchMode()
            reset()
            start()
        }
    }

    private func switchMode() {
        mode = (mode == .work) ? .pause : .work
    }
}
