//
//  Wallpaper_WidgetBundle.swift
//  Wallpaper-Widget
//
//  Created by MAC on 19/10/2023.
//

import WidgetKit
import SwiftUI
import AVFoundation

@main
@available(iOS 17.0, *)
struct Wallpaper_WidgetBundle: WidgetBundle {
    var body: some Widget {
        WallpaperWidget()
    }
}

@available(iOS 17.0, *)
struct WallpaperWidget: Widget {
    let kind: String = "WallpaperWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            WallpaperWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
                .onAppear {
                    
                        let audioSession = AVAudioSession.sharedInstance()
                        do {
                            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
                            try AVAudioSession.sharedInstance().setActive(true)
                            print("DEBUG: setup success")
                        } catch let error as NSError {
                            print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
                        }
                    
//                    do {
//                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//                        print("Playback OK")
//                        try AVAudioSession.sharedInstance().setActive(true)
//                        print("Session is Active")
//                    } catch {
//                        print("DEBUG: \(error.localizedDescription) error")
//                    }
                }
        }
        .contentMarginsDisabled()
        .supportedFamilies([ .systemMedium, .accessoryCircular,  .accessoryRectangular,])
//           systemSmall, .systemMedium, .systemLarge ,
//                            .accessoryCircular, .accessoryInline, .accessoryRectangular])
        
        
        
    }
}
