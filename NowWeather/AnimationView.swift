//
//  AnimationView.swift
//  NowWeather
//
//  Created by 정현 on 5/6/24.
//
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.animationSpeed = 1
        animationView.play()
        animationView.backgroundColor = .clear
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}
