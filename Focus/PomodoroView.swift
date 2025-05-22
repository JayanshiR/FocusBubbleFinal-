import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?

struct PomodoroView: View {
    @State private var workMinutes = 25
    @State private var breakMinutes = 5
    @State private var selectedSound = "dreamy-bells-47721.mp3"
    @StateObject private var timer = PomodoroTimer(workInSeconds: 1500, breakInSeconds: 300)
    @Environment(\.dismiss) var dismiss

    let availableSounds = [
        "dreamy-bells-47721.mp3",
        "level-win-6416.mp3",
        "lofi-alarm-clock-243766.mp3",
        "medieval-fanfare-6826.mp3",
        "orchestral-win-331233.mp3",
        "piglevelwin2mp3-14800.mp3",
        "shine-7-268909.mp3",
        "sound-effect-twinklesparkle-115095.mp3"
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Customize Your Timer")
                    .font(.headline)

                HStack {
                    VStack {
                        Text("Work (min)")
                        Picker("", selection: $workMinutes) {
                            ForEach(1..<61) { Text("\($0)") }
                        }
                        .labelsHidden()
                        .frame(width: 100)
                        .clipped()
                    }

                    VStack {
                        Text("Break (min)")
                        Picker("", selection: $breakMinutes) {
                            ForEach(1..<31) { Text("\($0)") }
                        }
                        .labelsHidden()
                        .frame(width: 100)
                        .clipped()
                    }
                }

                VStack {
                    Text("Select Sound")

                    Picker("Sound", selection: $selectedSound) {
                        ForEach(availableSounds, id: \.self) {
                            Text($0.replacingOccurrences(of: ".mp3", with: ""))
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Button {
                        playSound(named: selectedSound)
                    } label: {
                        Label("Preview Sound", systemImage: "speaker.wave.2.fill")
                            .font(.subheadline)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }

                Button("Start Session") {
                    let workSecs = workMinutes * 60
                    let breakSecs = breakMinutes * 60
                    timer.updateDurations(work: workSecs, breakTime: breakSecs)
                    timer.onSessionEnd = {
                        playSound(named: selectedSound)
                    }
                    timer.start()
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(12)

                Spacer()

                CircleTimer(
                    fraction: timer.fractionPassed,
                    primaryText: timer.secondsLeftString,
                    secondaryText: timer.mode.rawValue
                )

                HStack(spacing: 20) {
                    if timer.state == .running {
                        CircleButton(icon: "pause.fill") { timer.pause() }
                    } else if timer.state == .paused {
                        CircleButton(icon: "play.fill") { timer.start() }
                    }

                    CircleButton(icon: "arrow.clockwise") { timer.reset() }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Pomodoro")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
             
               
                    }
                }
            }
        }
    }

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            print("❌ Sound file not found: \(name)")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("❌ Could not play sound: \(error.localizedDescription)")
        }
    }

