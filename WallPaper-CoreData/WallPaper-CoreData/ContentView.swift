//
//  ContentView.swift
//  WallPaper-CoreData
//
//  Created by MAC on 13/11/2023.
//

import SwiftUI
import AVFoundation
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                WDNetworkManager.shared.requestApi { _ in
                    print("DEBUG: Done")
                }
            }, label: {
                Text("Load Data")
            })
//            LottieWrapper()
//                .frame(maxWidth: .infinity, maxHeight: 500)
//            
//            AnimatedImage(name: "gif_test.gif")
//                .frame(maxWidth: .infinity)
//                .frame(height: 300)
            WidgetView()
            
            

            
        }
        .padding()
    }
}

