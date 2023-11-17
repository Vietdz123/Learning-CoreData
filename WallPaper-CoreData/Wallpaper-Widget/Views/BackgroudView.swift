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
import Lottie
import SDWebImageSwiftUI


@available(iOS 17.0, *)
struct BackgroudView: View {
    
    var entry: SourceImageEntry
    let player = AVPlayer()
    
    var body: some View {
        ZStack {
//            WidgetView()
//            AnimatedImage(name: "gif_test.gif")
//            LottieView {
//                await LottieAnimation.loadedFrom(url: URL(string: "https://cdn-widget.eztechglobal.com/upload/files/full/2023/10/26/1698311113_y9DKz.json")! )
//              }
//                  .looping()
//                  .resizable()
//                  .scaledToFit()
//                  .frame(maxWidth: .infinity, maxHeight: .infinity)
//                  .overlay {
//                      Text("Siuuuuu")
//                  }
            
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
