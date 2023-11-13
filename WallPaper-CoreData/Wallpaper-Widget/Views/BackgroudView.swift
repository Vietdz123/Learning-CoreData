//
//  BackgroudView.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI
import WidgetKit
import AppIntents
import AVFoundation

@available(iOS 17.0, *)
struct BackgroudView: View {
    
    var entry: SourceImageEntry
    let player = AVPlayer()
    
    var body: some View {
        ZStack {
            Image(uiImage: entry.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                .ignoresSafeArea()
            
            
            Button(intent: ChangeBackgroundIntent(id_name: entry.imgSrc.actualName)) {
                Text("")
                    .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                    .background(Color.clear)
                
   
                
            }
            .buttonStyle(.plain)
            
//            Button(intent: SoundMakerIntent()) {
//                Text("")
//                    .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
//                    .background(Color.red)
//                
//   
//                
//            }
//            .buttonStyle(.plain)
            
            
//            PlayerWrapper()
//                .frame(maxWidth: entry.size.width / 2, maxHeight: entry.size.height / 2)
//                .background(.red)
            
        }.onAppear() {
            NotificationCenter.default.addObserver(forName: Notification.Name("NotificationIdentifier"), object: nil, queue: nil) { notification in
                print("DEBUG: play music")
                player.replaceCurrentItem(with: AVPlayerItem(url: URL(string: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3")!))
                player.play()
            }
        }
    }
    

}

