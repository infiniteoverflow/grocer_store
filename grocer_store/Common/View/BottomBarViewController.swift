//
//  BottomBarViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 21/02/23.
//

import UIKit

/// Defines the bottom-bar section of the view
class BottomBarViewController: UIViewController {
    
    // MARK: UI Views
    /// Defines the icon of the bottom-bar icon
    var bottomBarIcon = UIImage()
    
    /// Defines the container of the bottom-bar
    var bottomBar : UIView = {
        let uiv = UIView()
        uiv.backgroundColor = .blue
        return uiv
    }()

    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.frame = CGRect(x: 0, y: 200, width: 100, height: 70)
        bottomBar.backgroundColor = .green
        // Adds the bottom-bar to the view
        view.addSubview(bottomBar)
    }
}
