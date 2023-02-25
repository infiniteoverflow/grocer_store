//
//  ApiFetchFailViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 25/02/23.
//

import UIKit
import Lottie

// UI View to show when the API Fetcing fails.
class ApiFetchFailViewController: UIViewController {
    
    /// LottieAnimationView that handles the Lottie Animation
    private var animationView: LottieAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise the AnimationView with the "Loading.json" Lottie File.
        animationView = .init(name: AppAssets.somethingWentWrong)
          
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
}
