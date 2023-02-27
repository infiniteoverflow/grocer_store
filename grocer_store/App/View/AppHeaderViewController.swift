//
//  HeaderSectionViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 16/02/23.
//

import UIKit

/// Defines the Header Section of the App.
class AppHeaderViewController: UIViewController  {
    
    // MARK: Properties
    /// Properties
    var searchDelegate: UISearchBarDelegate? = nil
    
    // MARK: UI Views
    /// UI Views
    /// Gives the title of the header section.
    private var titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = AppFeatureString.explore
        tl.font = .systemFont(ofSize: 18,weight: .bold)
        return tl
    }()
    
    /// Gives the filter title of the header section.
    private var filterLabel: UILabel = {
        let tl = UILabel()
        tl.text = AppFeatureString.filter
        tl.font = .systemFont(ofSize: 16,weight: .regular)
        tl.textColor = AppColors.secondary
        return tl
    }()
    
    /// Search bar in the header section.
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.isTranslucent = false
        searchBar.barTintColor = .white
        searchBar.layoutIfNeeded()
        return searchBar
    }()

    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearchBar()
        setupLabels()
        addSubViews()
        addConstraints()
    }
    
    // MARK: Constraints
    // Add the constraints
    private func addConstraints() {
        
        // Constraints for the Title Label.
        let titleLabelTopConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant:50)
        let titleLabelLeadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 49)
        
        // Constraints for the Filter Label.
        let filterLabelTopConstraint = NSLayoutConstraint(item: filterLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 50)
        let filterLabelTrailingConstraint = NSLayoutConstraint(item: filterLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -34)
       
       // Constraints for the Search Bar.
        let searchBarTopConstraintWithTitle = NSLayoutConstraint(item: searchBar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 16)
        let searchBarTopConstraintWithFilter = NSLayoutConstraint(item: searchBar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: filterLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 16)
        let searchBarLeadingConstraint = NSLayoutConstraint(item: searchBar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 34)
        let searchBarTrailingConstraint = NSLayoutConstraint(item: searchBar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -34)
        let searchBarBottomConstraint = NSLayoutConstraint(item: searchBar, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -21)
        
        // Activate the constraints
        NSLayoutConstraint.activate([
            titleLabelTopConstraint,
            titleLabelLeadingConstraint,
            filterLabelTopConstraint,
            filterLabelTrailingConstraint,
            searchBarBottomConstraint,
            searchBarLeadingConstraint,
            searchBarTrailingConstraint,
            searchBarTopConstraintWithTitle,
            searchBarTopConstraintWithFilter
        ])
    }
    
    // MARK: Add Subviews
    // Add the subviews
    private func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(filterLabel)
        view.addSubview(searchBar)
    }
    
    // MARK: Setup View
    // Setup the View
    private func setupView() {
        view.backgroundColor = AppColors.primary
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 153)
    }
    
    // MARK: Setup SearchBar
    // Setup the Search Bar
    private func setupSearchBar() {
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
        searchBar.delegate = self.searchDelegate
        
        searchBar.layer.cornerRadius = 25
        searchBar.layer.masksToBounds = true
        
        searchBar.placeholder = AppFeatureString.search
        searchBar.searchBarStyle = .prominent
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.leftView = nil
    }
    
    // MARK: Setup Labels
    // Setup the Labels
    private func setupLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    

}
