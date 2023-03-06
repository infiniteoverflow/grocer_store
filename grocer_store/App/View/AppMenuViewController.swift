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
    
    // Used to display the User Profile Image
    let userImage = UIImageView()
    
    // Used to display the User Name
    let userName = UILabel()
    
    // Used to display the User Description
    let userDescription = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.secondary
        
        setupParentView()
        setupCloseButton()
        setupUserImage()
        setupUserName()
        setupUserDescription()
        
        setupCloseConstraints()
        setupUserImageConstraints()
        setupUserNameConstraints()
        setupUserDescriptionConstraints()
    }
    
    // MARK: UI View Methods
    // Setup the Parent View
    func setupParentView() {
        view.addSubview(closeButton)
        view.addSubview(userImage)
        view.addSubview(userName)
        view.addSubview(userDescription)
    }
    
    // Setup the User Description
    func setupUserDescription() {
        userDescription.text = "SDE-1 @ ZestMoney"
        userDescription.font = .systemFont(ofSize: 14)
        userDescription.tintColor = .gray
    }
    
    // Setup the User Name
    func setupUserName() {
        userName.text = "Aswin Gopinathan"
        userName.font = .systemFont(ofSize: 16,weight: .bold)
        userName.tintColor = .black
    }
    
    // Setup Close Button
    func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 20
        
        // Setup the Tap Gesture Recognizer.
        closeButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCloseTap))
        closeButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Setup the User Image
    func setupUserImage() {
        userImage.image = UIImage(named:"Me")
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.cornerRadius = 20
        userImage.clipsToBounds = true
        userImage.center = view.center
    }
    
    // MARK: UI Methods
    // Setup User Description Constraints
    func setupUserDescriptionConstraints() {
        userDescription.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: userDescription, attribute: .top, relatedBy: .equal, toItem: userName, attribute: .bottom, multiplier: 1, constant: 5)
        let leadingConstraint = NSLayoutConstraint(item: userDescription, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let heightConstraint = NSLayoutConstraint(item: userDescription, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        self.view.addConstraints([
            topConstraint,
            leadingConstraint,
            heightConstraint,
        ])
    }
    
    // Setup User Name Constraints
    func setupUserNameConstraints() {
        userName.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: userName, attribute: .top, relatedBy: .equal, toItem: userImage, attribute: .bottom, multiplier: 1, constant: 10)
        let leadingConstraint = NSLayoutConstraint(item: userName, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let heightConstraint = NSLayoutConstraint(item: userName, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        
        self.view.addConstraints([
            topConstraint,
            leadingConstraint,
            heightConstraint,
        ])
    }

    // Setup Image Constraints
    func setupUserImageConstraints() {
        userImage.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: userImage, attribute: .top, relatedBy: .equal, toItem: closeButton, attribute: .bottom, multiplier: 1, constant: 20)
        let leadingConstraint = NSLayoutConstraint(item: userImage, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        let widthConstraint = NSLayoutConstraint(item: userImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let heightConstraint = NSLayoutConstraint(item: userImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        
        self.view.addConstraints([
            topConstraint,
            leadingConstraint,
            widthConstraint,
            heightConstraint
        ])
    }
    
    // Constraints for the close button
    func setupCloseConstraints() {
        let closeTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
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
