//
//  ViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import UIKit

/// The entry point of the application.
/// The UIPageView is rendered from here.
class LandingPageViewController: UIViewController {

    // MARK: UI Views
    /// Parent container to host the UIPageViewController.
    let pageViewContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    /// Holds the UIPageViewController for the app.
    var appPageViewController: AppPageViewController!

    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // add myContainerView
        view.addSubview(pageViewContainer)

        NSLayoutConstraint.activate([
            pageViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            pageViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            pageViewContainer.heightAnchor.constraint(equalToConstant: view.frame.height),
            ])

        // instantiate MyPageViewController and add it as a Child View Controller
        appPageViewController = AppPageViewController()
        addChild(appPageViewController)

        // we need to re-size the page view controller's view to fit our container view
        appPageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        // add the page VC's view to our container view
        pageViewContainer.addSubview(appPageViewController.view)

        // constrain it to all 4 sides
        NSLayoutConstraint.activate([
            appPageViewController.view.topAnchor.constraint(equalTo: pageViewContainer.topAnchor, constant: 0.0),
            appPageViewController.view.bottomAnchor.constraint(equalTo: pageViewContainer.bottomAnchor, constant: 0.0),
            appPageViewController.view.leadingAnchor.constraint(equalTo: pageViewContainer.leadingAnchor, constant: 0.0),
            appPageViewController.view.trailingAnchor.constraint(equalTo: pageViewContainer.trailingAnchor, constant: 0.0),
            ])

        appPageViewController.didMove(toParent: self)
    }

}
