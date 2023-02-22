//
//  AppPageViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 21/02/23.
//

import UIKit

/// A UIPageViewController that takes care of the tabs displayed to the user.
class AppPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    // MARK: Properties
    /// Properties
    /// List of pages to be used in the PageView
    var pages: [UIViewController] = [UIViewController]()

    // MARK: Lifecycle Methods
    /// Lifecycle methods
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color of the view to be white
        view.backgroundColor = .white
        
        // Setting this class to provide the data source for the UIPageViewController
        dataSource = self
        
        // TableView of the app
        let productListingTableView = ProductListingTableView()
        
        // CollectionView of the app
        let productListingCollectionView = ProductListingCollectionView()
        
        // Connecting the searchDelegate of the TableView with the CollectionView
        // to pass the searchText between both the screens.
        productListingTableView.searchDelegate = productListingCollectionView

        // instantiate the pages
        pages.append(productListingTableView)
        pages.append(productListingCollectionView)
        
        // Add the header section to the view
        let headerSectionVC = HeaderSectionViewController()
        headerSectionVC.searchDelegate = productListingTableView
        view.addSubview(headerSectionVC.view)

        // Sets the ViewControllers to be displayed, with the initial page to be the first
        // page in the list, direction: Forward.
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return pages.last }

        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < pages.count else { return pages.first }

        guard pages.count > nextIndex else { return nil }

        return pages[nextIndex]
    }
}

