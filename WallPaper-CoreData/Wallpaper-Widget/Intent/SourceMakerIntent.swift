//
//  SourceMakerIntent.swift
//  WallPaper
//
//  Created by MAC on 09/11/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation


struct SoundMakerIntent: AudioPlaybackIntent {
    static var title: LocalizedStringResource = "Play a sound"
    static var description: IntentDescription = IntentDescription("Plays a widget sound")
    
    init() {}
    

    
    func perform() async throws -> some IntentResult {
        print("DEBUG: goto SoundMakerIntent")
        
        SoundPlayer.shared.play()
        return .result()
    }
}

class SoundPlayer: NSObject {
    static let shared = SoundPlayer()
    
//    private var player: AVAudioPlayer?
    private var player: AVPlayer = AVPlayer()
    
    func play() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        try? AVAudioSession.sharedInstance().setActive(true)

        
//        guard let player = try? AVAudioPlayer(contentsOf: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!) else { print("DEBUG: return cmnr"); return }
        
        player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!))
        
        player.play()
    }
}
