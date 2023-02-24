//
//  LoaderView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit
import Lottie

/// Shows a LottieAnimation while data is being fetched.
class LoaderView: UIViewController {
    
    /// LottieAnimationView that handles the Lottie Animation
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        // Initialise the AnimationView with the "Loading.json" Lottie File.
        animationView = .init(name: AppAssets.loading)
          
        // Set the frame of the View to cover the entire view.
        animationView!.frame = view.frame
        
        // Setting the AspectRatio of the Lottie view
        animationView!.contentMode = .scaleAspectFit
        
        // Loop the animation unless stopped.
        animationView!.loopMode = .loop

        // Define the animation speed of the Lottie Animation.
        animationView!.animationSpeed = 1.5
        
        // Start the Lottie animation
        animationView?.play()
        
        // Add the LottiAnimationView to the Superview.
        view.addSubview(animationView!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        animationView?.stop()
    }
}
