//
//  HeaderSectionViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 16/02/23.
//

import UIKit

class HeaderSectionViewController: UIViewController, UISearchBarDelegate  {
    
    /// Gives the title of the header section.
    private var titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Explore"
        tl.font = .systemFont(ofSize: 18,weight: .bold)
        return tl
    }()
    
    /// Gives the filter title of the header section.
    private var filterLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Filter"
        tl.font = .systemFont(ofSize: 16,weight: .regular)
        tl.textColor = Utils.hexStringToUIColor(hex: "5DB075")
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
        let viewsDict = [
            "titleLabel" : titleLabel,
            "filterLabel" : filterLabel,
            "searchBar" : searchBar
        ] as [String : Any]
        
        var constraints: [NSLayoutConstraint] = []
        
        let verticalAlignTitle = NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-|", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignTitle
        
        let verticalAlignFilterToSearchBar = NSLayoutConstraint.constraints(withVisualFormat: "V:[filterLabel]-15-[searchBar(50)]-15-|", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignFilterToSearchBar
                
        let horizAlignTitleToFilter = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-[filterLabel]-20-|", options: [], metrics: nil, views: viewsDict)
        constraints += horizAlignTitleToFilter
        
        let horizAlignSearch = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[searchBar]-20-|", options: [], metrics: nil, views: viewsDict)
        constraints += horizAlignSearch
        
        view.addConstraints(constraints)
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
        view.backgroundColor = Utils.hexStringToUIColor(hex: "E6E9F7")
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 180)
    }
    
    // MARK: Setup SearchBar
    // Setup the Search Bar
    private func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 25
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor.white
        searchBar.tintColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Setup Labels
    // Setup the Labels
    private func setupLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    

}
