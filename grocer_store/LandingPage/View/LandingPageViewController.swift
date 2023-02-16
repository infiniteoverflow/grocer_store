//
//  ViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import UIKit
import Combine

class LandingPageViewController: UITabBarController {
    
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createBottomBar()
        createHeaderSection()
    }
    
    // Define the header section
    private func createHeaderSection() {
        self.view.addSubview(HeaderSectionViewController().view)
    }
    
    // Setup the superview
    private func setupView() {
        view.backgroundColor = .white
        tabBar.backgroundColor = .white
    }
    
    // Define a BottomBar
    private func createBottomBar() {
        
        // TableView
        let vc1 = UINavigationController(rootViewController: ProductListingTableView())
        
        // CollectionView
        let vc2 = UINavigationController(rootViewController: ProductListingCollectionView())
        
        self.setViewControllers([vc1,vc2], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let tabBarImageItem = ["tablecells","square.grid.2x2"]
        let tabBarSelectedImageItem = ["tablecells.fill", "square.grid.2x2.fill"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: tabBarImageItem[i])
            items[i].selectedImage = UIImage(systemName: tabBarSelectedImageItem[i])
        }
    }
}
