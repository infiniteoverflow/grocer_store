//
//  ViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import UIKit
import Combine

class LandingPageViewController: UITabBarController {
    
    // MARK: Properties
    /// Properties
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    // ViewModel class that contains logic for interacting the model
    // with the UI View.
    var viewModel = ViewModel()
    
    // MARK: Lifecycle Methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createBottomBar()
        createHeaderSection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.frame.size.height = 90
    }
    
    // MARK: View Methods
    /// View Methods
    // Define the header section
    private func createHeaderSection() {
        self.view.addSubview(HeaderSectionViewController().view)
    }
    
    // Setup the superview
    private func setupView() {
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
        tabBar.tintColor = .green
    }
    
    // Define a BottomBar
    private func createBottomBar() {
        
        // TableView
        let vc1 = UINavigationController(rootViewController: ProductListingTableView())
        
        // CollectionView
        let vc2 = UINavigationController(rootViewController: ProductListingCollectionView())
        
        // EmptyViewControllers
        let vc3 = UINavigationController(rootViewController: EmptyViewController())
        let vc4 = UINavigationController(rootViewController: EmptyViewController())
        let vc5 = UINavigationController(rootViewController: EmptyViewController())
        
        self.setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        for i in 0..<items.count {
            items[i].image = UIImage(named: "BottomCircleGray")
        }
    }
}
