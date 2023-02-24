//
//  EmptySearchResultViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 22/02/23.
//

import UIKit
import Lottie

class EmptySearchResultViewController: UIViewController {
    
    /// LottieAnimationView that handles the Lottie Animation
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise the AnimationView with the "Loading.json" Lottie File.
        animationView = .init(name: AppAssets.emptyResult)
          
        // Set the frame of the View to cover the entire view.
        animationView!.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        // Setting the AspectRatio of the Lottie view
        animationView!.contentMode = .top
        
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
