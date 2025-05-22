import AVFoundation

class SoundManager {
    static var player: AVAudioPlayer?

    static func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
            print("🔇 Sound file not found: \(name)")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("❌ Failed to play sound: \(error)")
        }
    }
}
