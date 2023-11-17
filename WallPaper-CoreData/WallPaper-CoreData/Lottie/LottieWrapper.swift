//
//  LottieWrapper.swift
//  WallPaper-CoreData
//
//  Created by MAC on 15/11/2023.
//

import UIKit
import Lottie
import SwiftUI

struct LottieWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> LottieController {
        return LottieController()
    }
    
    func updateUIViewController(_ uiViewController: LottieController, context: Context) {
        
    }
 
    
    
    
    
}


struct BlueWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> BlueView {
        
        let blue = BlueView(frame: .init(x: 0, y: 0, width: 300, height: 300))
        blue.backgroundColor  = .blue
        return blue
    }
    
    func updateUIView(_ uiView: BlueView, context: Context) {
        
    }
    

    
    
    
    
}

class BlueView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LottieController: UIViewController {
    
    // MARK: - Properties
    private lazy var animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "go_mo.json")
        //LottieAnimationView(url: URL(string: "https://cdn-widget.eztechglobal.com/upload/files/full/2023/10/26/1698311113_y9DKz.json")!) { _ in
            
        //}
        
        animation.animationLoaded = { animationView, animation in
            animationView.play()
        }
//        LottieAnimationView(name: "go_mo.json")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 1
        return animation
    }()

    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        animationView.play()
    }
    
    
    // MARK: - Methods
    
    
    // MARK: - Selectors
    
}

struct WidgetView: View {

    var body: some View {
        LottieView {
            await LottieAnimation.loadedFrom(url: Bundle.main.url(forResource: "go_mo", withExtension: "json")! )
        }
              .looping()
              .resizable()
              .scaledToFit()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .overlay {
                  Text("Siuuuuu")
              }

    }
}

//struct GIFWidget: View {
//    let gifURL = Bundle.main.url(forResource: "gif_test", withExtension: "json")!
//
//    var body: some View {
//        Image(gifURL)
//    }
//}
