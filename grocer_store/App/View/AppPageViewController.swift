//
//  PageViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 23/02/23.
//

import Foundation
import UIKit

protocol PageViewControllerDelegate: AnyObject {
    func pageDidSwipe(to index: Int)
}

/// ViewController that handles the Page Action.
class AppPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    // MARK: Properties
    /// A Delegate for Swipe Actions.
    weak var swipeDelegate: PageViewControllerDelegate?
    
    /// Holds the list of pages
    var pages = [UIViewController]()
    
    var prevIndex: Int = 1
    
    // MARK: Lifecycle methods
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else { return nil }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentPageIndex = self.viewControllers?.first?.view.tag else { return }
            self.prevIndex = currentPageIndex
            self.swipeDelegate?.pageDidSwipe(to: currentPageIndex)
        }
    }
    
    // MARK: UI Methods
    func selectPage(at index: Int) {
        self.setViewControllers(
            [self.pages[index]],
            direction: self.direction(for: index),
            animated: true,
            completion: nil
        )
        self.prevIndex = index
    }
    
    private func direction(for index: Int) -> UIPageViewController.NavigationDirection {
        return index > self.prevIndex ? .forward : .reverse
    }
    
}
