//
//  HeaderSectionViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 16/02/23.
//

import UIKit

class HeaderSectionViewController: UIViewController, UISearchBarDelegate  {
    
    private var horizStackView: UIStackView = {
       let hsv = UIStackView()
        hsv.axis = .horizontal
        hsv.alignment = .fill
        hsv.distribution = .fill
        return hsv
    }()
    
    private var vertiStackView: UIStackView = {
       let hsv = UIStackView()
        hsv.axis = .vertical
        hsv.alignment = .fill
        hsv.distribution = .fill
        return hsv
    }()
    
    private var titleLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Explore"
        tl.font = .systemFont(ofSize: 18,weight: .bold)
        return tl
    }()
    
    private var filterLabel: UILabel = {
        let tl = UILabel()
        tl.text = "Filter"
        tl.font = .systemFont(ofSize: 16,weight: .regular)
        tl.textColor = Utils.hexStringToUIColor(hex: "5DB075")
        return tl
    }()
    
    private var searchBar: UISearchBar = {
              let searchBar = UISearchBar()
              searchBar.isTranslucent = false
              searchBar.barTintColor = .white
              searchBar.layoutIfNeeded()
              return searchBar
          }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Utils.hexStringToUIColor(hex: "E6E9F7")
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 180)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 25
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = UIColor.white
        searchBar.tintColor = .white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        searchBar.searchTextField.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDict = [
            "titleLabel" : titleLabel,
            "filterLabel" : filterLabel,
            "searchBar" : searchBar
        ] as [String : Any]
        
        view.addSubview(titleLabel)
        view.addSubview(filterLabel)
        view.addSubview(searchBar)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[filterLabel]-15-[searchBar(50)]-15-|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[titleLabel]-[filterLabel]-20-|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[searchBar]-20-|", options: [], metrics: nil, views: viewsDict))
    }
    
    

}
