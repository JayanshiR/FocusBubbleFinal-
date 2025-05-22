import SwiftUI
import AVKit

struct CalmVideoPlayer: View {
    var videoName: String
    var fileExtension: String = "mp4"
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: videoURL))
            .onAppear {
                // Autoplay if needed
                AVPlayer(url: videoURL).play()
            }
    }

    private var videoURL: URL {
        #if DEBUG
        // Use a short, lightweight video in preview
        return Bundle.main.url(forResource: "calm_preview", withExtension: fileExtension)!
        #else
        // Use your actual long video in production
        return Bundle.main.url(forResource: videoName, withExtension: fileExtension)!
        #endif
    }
}


struct CalmVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CalmVideoPlayer(videoName: "long_video_file") // will use dummy in preview
    }
}
