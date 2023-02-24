//
//  TabBarViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 23/02/23.
//

import UIKit

class AppViewController: UITabBarController,UITabBarControllerDelegate, PageViewControllerDelegate {
    
    // MARK: View Properties
    /// View Properties
    /// The color for the selected TabBarItem
    let selectedColor = Utils.hexStringToUIColor(hex: "5DB075")
    
    /// The color for the de-selected TabBarItem
    let deselectedColor = Utils.hexStringToUIColor(hex: "E8E8E8")
    
    /// The Image for the TabBarItem
    var tabBarImage = UIImage(named: "BottomCircle")!
    
    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        self.delegate = self
        tabBar.isTranslucent = true
        tabBar.itemSpacing = 10.0
        tabBar.itemWidth = 76.0
        tabBar.itemPositioning = .centered
    
        setUpTheViewController()
        
        self.selectPage(at: 0)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.selectPage(at: viewController.view.tag)
        return false
    }
    
    func pageDidSwipe(to index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
    }
    
    // MARK: UI Methods
    /// UI Methods
    /// Setup the ViewControllers to be used for the app.
    private func setUpTheViewController() {
        
        guard let centerPageViewController = createCenterPageViewController() else { return }
        
        var controllers: [UIViewController] = []
        
        controllers.append(createPlaceholderViewController(forIndex: 0))
        controllers.append(centerPageViewController)
        controllers.append(createPlaceholderViewController(forIndex: 2))
        controllers.append(createPlaceholderViewController(forIndex: 3))
        controllers.append(createPlaceholderViewController(forIndex: 4))
        
        setViewControllers(controllers, animated: false)
        
        selectedViewController = centerPageViewController
    }
    
    /// Selects the page based on the `index` passed.
    private func selectPage(at index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
        guard let PageViewController = (self.viewControllers?[1] as? AppPageViewController) else { return }
        PageViewController.selectPage(at: index)
    }
    
    /// Creates a Placeholder ViewController.
    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = tabbarItem()
        emptyViewController.view.tag = index
        return emptyViewController
    }
    
    /// Creates a PageViewController for multiple tabs.
    private func createCenterPageViewController() -> UIPageViewController? {
        
        // TableView of the app
        let productListingTableView = ProductListingTableView()
        
        // CollectionView of the app
        let productListingCollectionView = ProductListingCollectionView()
        
        // Connecting the searchDelegate of the TableView with the CollectionView
        // to pass the searchText between both the screens.
        productListingTableView.searchDelegate = productListingCollectionView
        
        // View for showing the Upcoming Screens
        let upcomingView1 = ComingSoonViewController()
        let upcomingView2 = ComingSoonViewController()
        let upcomingView3 = ComingSoonViewController()
        
        
        // Add the header section to the view
        let appHeaderViewController = AppHeaderViewController()
        appHeaderViewController.searchDelegate = productListingTableView
        view.addSubview(appHeaderViewController.view)
        
        // Setting the tag for individual views so that they can be
        // easily distinguishable during tab index change.
        productListingTableView.view.tag = 0
        productListingCollectionView.view.tag = 1
        upcomingView1.view.tag = 2
        upcomingView2.view.tag = 3
        upcomingView3.view.tag = 4
        
        let pageViewController = AppPageViewController()
        
        // Attach the views to the PageViewController.
        pageViewController.pages = [
            productListingTableView,
            productListingCollectionView,
            upcomingView1,
            upcomingView2,
            upcomingView3,
        ]
        
        // Define the TabBarItem for the PageViewController.
        pageViewController.tabBarItem = tabbarItem()
        pageViewController.view.tag = 1
        pageViewController.swipeDelegate = self
        
        return pageViewController
    }
    
    // Defines the TabBarItem UI.
    private func tabbarItem() -> UITabBarItem {
        let uiTabBarItem = UITabBarItem(title: nil, image: tabBarImage, selectedImage: nil)
        uiTabBarItem.imageInsets = UIEdgeInsets(top: 14.5, left: 0, bottom: -14.5, right: 0)
        return uiTabBarItem
    }
    
    // Handle the change in TabBarItem during user-click or swipe.
    private func handleTabbarItemChange(viewController: UIViewController) {
        guard let viewControllers = self.viewControllers else { return }
        let selectedIndex = viewController.view.tag
        self.tabBar.tintColor = deselectedColor
        self.tabBar.unselectedItemTintColor = deselectedColor
        
        for i in 0..<viewControllers.count {
            let tabbarItem = viewControllers[i].tabBarItem
            let tabbarImage = self.tabBarImage
            tabbarItem?.selectedImage = tabbarImage.withRenderingMode(.alwaysTemplate)
            tabbarItem?.image = tabbarImage.withRenderingMode(
                i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
            )
        }
        
        if selectedIndex == 1 {
            viewControllers[selectedIndex].tabBarItem.selectedImage =  self.tabBarImage.withRenderingMode(.alwaysOriginal)
        }
    }
}
