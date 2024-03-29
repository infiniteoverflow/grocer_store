//
//  TabBarViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 23/02/23.
//

import UIKit

class AppViewController: UITabBarController,UITabBarControllerDelegate, PageViewControllerDelegate, SideMenuDelegate {
    
    // MARK: View Properties
    /// View Properties
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    var isSlideInMenuPresented = false
    
    /// The color for the selected TabBarItem
    let selectedColor = AppColors.secondary
    
    /// The color for the de-selected TabBarItem
    let deselectedColor = AppColors.appLightGray
    
    /// The Image for the TabBarItem
    var tabBarImage = UIImage(named: AppAssets.bottomCircleGreen)!
    
    /// Header Section of the App.
    let appHeaderViewController = AppHeaderViewController()
    
    lazy var menuViewController = AppMenuViewController()
    
    // TableView of the app
    let productListingTableView = ProductListingTableView()
    
    // CollectionView of the app
    let productListingCollectionView = ProductListingCollectionView()
    
    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        setupTabBar()
        setUpTheViewController()
        selectPage(at: 0)
        setupSideMenu()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.selectPage(at: viewController.view.tag)
        return false
    }
    
    func pageDidSwipe(to index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
    }
    
    // Delegate method that tells if the side menu was triggered.
    func menuButtonTapped() {
        self.menuViewController.view.isHidden.toggle()
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuViewController.view.frame.size = CGSize(width: self.view.frame.width * 0.8, height: self.menuViewController.view.frame.height)
        } completion: { (finished) in
            
        }
    }
    
    // MARK: UI Methods
    /// UI Methods
    /// Setup the TabBar
    private func setupTabBar() {
        self.delegate = self
        tabBar.isTranslucent = true
        tabBar.itemSpacing = 10.0
        tabBar.itemWidth = 76.0
        tabBar.itemPositioning = .centered
    }
    
    /// Setup the Side Menu
    private func setupSideMenu() {
        menuViewController.menuButtonDelegate = self
        menuViewController.view.pinMenuTo(view, with: slideInMenuPadding)
        menuViewController.view.isHidden = true
        menuViewController.view.frame.size = CGSize(width: 0, height: self.menuViewController.view.frame.height)
        menuViewController.view.accessibilityIdentifier = "MenuViewController"
    }
    
    /// Setup the ViewControllers to be used for the app.
    private func setUpTheViewController() {
        view.backgroundColor = .white
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
        
        // Connecting the searchDelegate of the TableView with the CollectionView
        // to pass the searchText between both the screens.
        productListingTableView.searchDelegate = productListingCollectionView
        
        // View for showing the Upcoming Screens
        let upcomingView1 = ComingSoonViewController()
        let upcomingView2 = ComingSoonViewController()
        let upcomingView3 = ComingSoonViewController()
        
        
        // Add the header section to the view
        appHeaderViewController.searchDelegate = productListingTableView
        appHeaderViewController.menuButtonDelegate = self
        
        view.addSubview(appHeaderViewController.view)
        
        setupHeaderConstraints(appHeaderViewController: appHeaderViewController)
        
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
    
    // Setup constraints for the header section
    private func setupHeaderConstraints(appHeaderViewController: UIViewController) {
        let headerTopConstraint = NSLayoutConstraint(item: appHeaderViewController.view!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let headerLeadingConstraint = NSLayoutConstraint(item: appHeaderViewController.view!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let headerTrailingConstraint = NSLayoutConstraint(item: appHeaderViewController.view!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let headerHeight = NSLayoutConstraint(item: appHeaderViewController.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 153)
        
        view.addConstraints([
            headerTopConstraint,
            headerLeadingConstraint,
            headerTrailingConstraint,
            headerHeight
        ])
        
        NSLayoutConstraint.activate(view.constraints)
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
        
        if selectedIndex == 1 {
            appHeaderViewController.filterDelegate = productListingCollectionView
        } else if selectedIndex == 0 {
            appHeaderViewController.filterDelegate = productListingTableView
        }
        
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

public extension UIView {
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
