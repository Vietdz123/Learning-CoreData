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
        guard let cate = CoreDataService.shared.getCategory(name: id_name) else { return .result() }
        
        let urls = CoreDataService.shared.getSounds(category: cate, family: .singleSound)
        if let url = urls.first {
            SoundPlayer.shared.play(url: url)
        }
        
        return .result()
    }
}

class SoundPlayer: NSObject {
    static let shared = SoundPlayer()
    var observer: NSKeyValueObservation!
    var updateStatus: UpdateCurrentType = .reset
    
    let player: AVPlayer = AVPlayer()
    
    
    func play(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            
        } catch {
            print("DEBUG: \(error.localizedDescription) error")
        }
        
        print("DEBUG: goto play")
        
//        let fakeurl = URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!
        if player.currentItem == nil {
            let item = AVPlayerItem(url: url)
            player.replaceCurrentItem(with: item)
            observer = item.observe(\.status, options: []) { item, value in
                switch item.status {
                case .readyToPlay:
                    print("DEBUG: readyToPlay")
                    self.player.play()
                default :
                    print("DEBUG: failed to play")
                }
            }
        } else {
            player.seek(to: .zero)
            player.play()
        }

        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status

            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            // Switch over status value
            switch status {
            case .readyToPlay:
                player.play()
                print("Player item is ready to play.")
                break
            case .failed:
                print("Player item failed. See error")
                break
            case .unknown:
                print("Player item is not yet ready")
                break
            @unknown default:
                fatalError()
            }
        }
    }
}

