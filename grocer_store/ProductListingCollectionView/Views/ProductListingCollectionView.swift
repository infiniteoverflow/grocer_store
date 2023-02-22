//
//  ProductListingCollectionView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit
import Combine

class ProductListingCollectionView: UIPageViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // MARK: Properties
    /// Properties
    /// List of properties used by the controller
    
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    
    // ViewModel class that contains logic for interacting the model
    // with the UI View.
    private var viewModel = ViewModel()
    
    // Stores the store items
    private var storeResponse: [Item] = []
    
    // Stores the store items in a temp list
    private var tempStoreResponse: [Item] = []
    
    // MARK: UI Elements
    /// UI Elements
    // Label to show an error message if the API fails
    private var errorLabel: UILabel!
    
    // Defines the CollectionView for displaying the data.
    var collectionview: UICollectionView?
    
    // Performs the pull to refresh on the ViewController
    let refreshControl = UIRefreshControl()
    
    // Empty Search Result UI
    private let emptySearchResultView = EmptySearchResultViewController()
    
    // MARK: View Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModelListener()
        setupErrorLabel()
        setupCollectionView()
        setupRefreshController()
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        storeResponse = tempStoreResponse
        collectionview?.backgroundView = nil
        if searchText.isEmpty {
            collectionview?.reloadData()
            return
        }
        storeResponse = storeResponse.filter { item in
            return item.contains(text: searchText.lowercased())
        }
        
        if storeResponse.isEmpty {
            collectionview?.backgroundView = emptySearchResultView.view
        }
        
        collectionview?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storeResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.item = storeResponse[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 110, height: 160)
    }
    
    // MARK: UI Methods
    // Setup the Collection View to show the grid of store items.
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview?.dataSource = self
        collectionview?.delegate = self
        collectionview?.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionview?.backgroundColor = .white
        collectionview?.contentInset = UIEdgeInsets(top: 39, left: 20, bottom: 10,right: 0)
        collectionview?.bounces = true
        collectionview?.alwaysBounceVertical = true
        collectionview?.frame = CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: self.view.frame.size.height - 180)
    }
    
    // Setup the Error Label to show any error messages
    func setupErrorLabel() {
        errorLabel = UILabel(frame: self.view.frame)
        errorLabel.text = "Something went wrong, \nPlease try again later"
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        errorLabel.numberOfLines = 2
    }
    
    // Setup the RefreshController to be used for swipe-down-to-refresh
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        collectionview?.addSubview(refreshControl)
    }
    
    // MARK: View methods
    /// View Methods
    /// Execute this method when we pull to refresh the view
    @objc func refresh() {
        fetchData()
    }
    
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            await viewModel.getStoreDetails()
        }
    }
    
    // Attach listeners to listen to the Network call
    // to fetch store data.
    func attachViewModelListener() {
        cancellable = viewModel.$store.sink {
            if($0.isLoading == true) {
                Task {
                    if !self.refreshControl.isRefreshing {
                        self.view.addSubview(LoaderView().view)
                    }
                }
            } else {
                Task {
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
                if($0.error != "") {
                    Task {
                        self.view.addSubview(self.errorLabel)
                    }
                }
                else {
                    guard let response = $0.success else {return}
                    self.storeResponse = response
                    self.tempStoreResponse = response
                    Task {
                        self.view.addSubview(self.collectionview!)
                    }
                }
            }
        }
    }
    
}
