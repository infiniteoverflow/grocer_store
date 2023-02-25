//
//  ProductListingCollectionView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

class ProductListingCollectionView: UIPageViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, Subscriber {
    
    // MARK: Properties
    /// Properties
    /// List of properties used by the controller
    
    // Defines the debounce timer for the search text comparison.
    var searchDebounceTimer: Timer?
    
    // ViewModel class that contains logic for interacting the model
    // with the UI View.
    private var viewModel = ViewModel.instance
    
    // Stores the store items
    private var storeResponse: [Item] = []
    
    // Stores the store items in a temp list
    private var masterStoreResponse: [Item] = []
    
    // MARK: UI Elements
    /// UI Elements
    // Label to show an error message if the API fails
    private var errorLabel: UILabel!
    
    // Defines the CollectionView for displaying the data.
    var collectionview: UICollectionView!
    
    // Performs the pull to refresh on the ViewController
    let refreshControl = UIRefreshControl()
    
    // Defines the LoaderView to show to the user when data
    // is being loaded.
    let loader = LoaderView()
    
    // Empty Search Result UI
    private let emptySearchResultView = EmptySearchResultViewController()
    
    // MARK: View Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup this class as a Subscriber to the Publiser.
        setupSubscriber()
        // Setup the Error view.
        setupErrorLabel()
        // Setup the CollectionView.
        setupCollectionView()
        // Setup the Pull-down-to-refresh View.
        setupRefreshController()
    }
    
    // Called when the text in the searchbar changes.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Stop the timer if its running.
        searchDebounceTimer?.invalidate()
        
        // Restart the timer, and perform the closure action after the given interval.
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            self.filterData(searchText: searchText)
        }
    }
    
    // Defines the count of items to be displayed in the CollectionView.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storeResponse.count
    }
    
    // Defines the UICollectionViewCell.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        cell.item = storeResponse[indexPath.row]
        return cell
    }
    
    // Defines the size of the individual item in the CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 145)
    }
    
    // Get the Publisher data.
    func getPublisherData(state: NetworkState, extra: Any?) {
        switch state {
        case .loading:
            setupLoader()
        case .success:
            self.stopLoaderAndRefreshViewAnimation()
            guard let response = extra as? [Item] else { return }
            self.storeResponse = response
            self.masterStoreResponse = response
            
            self.attachCollectionView()
        default:
            self.stopLoaderAndRefreshViewAnimation()
            self.attachErrorView()
        }
    }
    
    // MARK: UI Methods
    // Setup this class as a Subsriber.
    func setupSubscriber() {
        Publisher.instance.subscribe(subscriber: self)
    }
    
    // Perform Filter on the ui data based on the search text.
    func filterData(searchText: String) {
        storeResponse = masterStoreResponse
        collectionview?.backgroundView = nil
        if searchText.isEmpty {
            collectionview?.reloadData()
            return
        }
        storeResponse = storeResponse.filter { item in
            return item.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
        if storeResponse.isEmpty {
            collectionview?.backgroundView = emptySearchResultView.view
        }
        
        collectionview?.reloadData()
    }
    
    // Setup the Collection View to show the grid of store items.
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 35
        layout.minimumLineSpacing = 0
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionview.backgroundColor = .white
        collectionview.contentInset = UIEdgeInsets(top: 39, left: 20, bottom: 10,right: 0)
        collectionview.bounces = true
        collectionview.alwaysBounceVertical = true
        collectionview.frame = CGRect(x: 0, y: 153, width: self.view.frame.size.width, height: self.view.frame.size.height - 153)
        collectionview.contentInset = UIEdgeInsets(top: 39, left: 32, bottom: 0, right: 60)
        collectionview.keyboardDismissMode = .onDrag
        collectionview.addSubview(refreshControl)
    }
    
    // Setup the Error Label to show any error messages
    func setupErrorLabel() {
        errorLabel = UILabel(frame: self.view.frame)
        errorLabel.text = AppString.apiErrorString
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        errorLabel.numberOfLines = 2
    }
    
    // Setup the RefreshController to be used for swipe-down-to-refresh
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: AppString.refreshText)
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
    }
    
    // Setup the loader if the view state is "Loading"
    func setupLoader() {
        Task {
            if !self.refreshControl.isRefreshing {
                self.view.addSubview(self.loader.view)
            }
        }
    }
    
    // Dispose Loader and Refresh View Animation
    func stopLoaderAndRefreshViewAnimation() {
        Task {
            self.loader.removeFromParent()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // Attach the TableView
    func attachCollectionView() {
        Task {
            self.view.addSubview(self.collectionview!)
        }
    }
    
    // Attach the Error View
    func attachErrorView() {
        Task {
            self.view.addSubview(self.errorLabel)
        }
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
    
}
