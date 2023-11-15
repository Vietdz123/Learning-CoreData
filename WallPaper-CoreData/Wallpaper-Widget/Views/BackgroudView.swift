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
            
            if entry.imgViewModel.category?.hasSound == true {
                Button(intent: SoundMakerIntent(id_name: entry.imgSrc.actualName)) {
                    Text("")
                        .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                        .background(Color.clear)

                }
                .buttonStyle(.plain)
            } else {
                Button(intent: ChangeBackgroundIntent(id_name: entry.imgSrc.actualName)) {
                    Text("")
                        .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
                        .background(Color.clear)
    
    
    
                }
                .buttonStyle(.plain)
            }

        }
    }
    

}

