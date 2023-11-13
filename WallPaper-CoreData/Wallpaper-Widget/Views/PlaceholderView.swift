//
//  PlaceholderView.swift
//  WallPaper
//
//  Created by MAC on 23/10/2023.
//

import SwiftUI

struct PlaceholderView: View {
    
    var size: CGSize
    
    var body: some View {
        ZStack {
            
            Image(uiImage: UIImage(named: AssetConstant.imagePlacehodel)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(maxWidth: size.width, maxHeight: size.height)
                .ignoresSafeArea()
            
            
            VStack {
                
                HStack {
                    Image(uiImage: UIImage(named: AssetConstant.logo)!)
                        .resizable()
                        .frame(width: 40, height: 40)
                    
                    Text("My Screen")
                        .font(.system(size: 23))
                        .foregroundColor(.white)
                }
                
                Text("1. Touch and hold this widget ti=o edit")
                Text("2. Tap Edit Widget")
                Text("3. Choose a widget from the app")
            }
            .foregroundColor(.white)
        }
    }
}

