//
//  AppMenuViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 06/03/23.
//

import UIKit

class AppMenuViewController: UIViewController {
    
    /// Delegate instance for Menu Button Pressed
    var menuButtonDelegate: SideMenuDelegate? = nil
    
    // Shows the Close Button for the Side Menu
    let closeButton = UIButton(type: .close)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.secondary
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup the Tap Gesture Recognizer.
        closeButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCloseTap))
        closeButton.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview(closeButton)
        setCloseConstraints()
    }
    
    // Constraints for the close button
    func setCloseConstraints() {
        let closeTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 30)
        let closeLeadingConstraint = NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        
        self.view.addConstraints([
            closeTopConstraint,
            closeLeadingConstraint,
        ])
    }
    
    // Close Button Tap Gesture Recognizer action
    @objc func onCloseTap() {
        self.menuButtonDelegate?.menuButtonTapped()
    }
}
