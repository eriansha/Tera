//
//  LottieView.swift
//  Tera
//
//  Created by Ivan on 03/05/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
//    typealias UIViewType = UIView
    var url: String

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        // This lines creates a new AnimationView object named animationView.
        // AnimationView is a class provided by the Lottie framework that is used to display Lottie Animations
        let animationView = LottieAnimationView()
        // set Lottie animation file and set it as animation to be displayed by animationView
        let animation = LottieAnimation.named(url)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        // Create layout constraints between views in iOS and macOS applications
        // Constraints are used to specify the position and size of views relative to each other, and to create adaptive
        // layouts that work well on different screen sizes and device orientations.
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // TODO
    }
}
