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
    
    @Parameter(title: "Name ID")
    var id_name: String
    
    init(id_name: String) {
        self.id_name = id_name
    }
    
    func perform() async throws -> some IntentResult {
        print("DEBUG: goto SoundMakerIntent")
        guard let cate = CoreDataService.shared.getCategory(name: id_name) else { print("DEBUG: return 123"); return .result() }
        
        let urls = CoreDataService.shared.getSounds(category: cate, family: .singleSound)

        if let url = urls.first {
            print("DEBUG: update")
            WidgetViewModel.shared.dict[id_name]?.updateCurrentIndex()
            SoundPlayer.shared.play(url: url)
        }
        
//        SoundPlayer.shared.play()
        return .result()
    }
}

class SoundPlayer: NSObject {
    static let shared = SoundPlayer()
    
    let player: AVPlayer = AVPlayer()
    
    func play(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
            print("DEBUG: error success")
        } catch {
            print("DEBUG: \(error.localizedDescription) error")
        }
        
        print("DEBUG: goto play")
        let fakeUrl = URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
    }
}

