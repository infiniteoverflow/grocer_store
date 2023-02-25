//
//  ProductListingTableView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

/// Defins the table view of the store data
class ProductListingTableView: UIPageViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, Subscriber {
    
    // MARK: Properties
    /// Properties
    /// List of properties used by the controller
    /// Delegate for passing the search data to another view
    var searchDelegate: UISearchBarDelegate? = nil
    
    // Defines the debounce timer for the search text comparison.
    var searchDebounceTimer: Timer?
    
    /// Data instances
    // Stores the store items
    private var storeResponse: [Item] = []
    // ViewModel class that contains logic for interacting the model
    
    // Stores the store items in a temp list
    private var masterStoreResponse: [Item] = []
    
    // with the UI View.
    private var viewModel = ViewModel.instance
    
    // MARK: UI Elements
    /// UI Elements
    // Defines the table view that renders the API response.
    private var myTableView: UITableView!
    
    // View to show an error message if the API fails
    private var errorView = ApiFetchFailViewController()
    
    // Loader to show when data is being fetched from the network.
    let loader = LoaderView()
    
    // Empty Search Result UI
    private let emptySearchResultView = EmptySearchResultViewController()
    
    // Performs the pull to refresh on the ViewController
    let refreshControl = UIRefreshControl()
        
    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup this class as a Subscriber to the Publiser.
        setupSubscriber()
        // Fetch API Data.
        fetchData()
        // Setup the TableView.
        setupTableView()
        // Setup the Pull-down-to-refresh View.
        setupRefreshController()
    }
    
    // Defines the count of items to be displayed in the TableView.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storeResponse.count
    }
    
    // Defines the UITableViewCell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListingTableItem.identifer, for: indexPath) as! ProductListingTableItem
        cell.productItem = storeResponse[indexPath.row]
        return cell
    }
    
    // Defines the height of the individual row.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    // Called when the text in the searchbar changes.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Stop the running timer.
        searchDebounceTimer?.invalidate()
        
        // Restart the timer
        searchDebounceTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in
            self.filterData(searchBar: searchBar, searchText: searchText)
        }
    }
    
    // Called when the Search Button is clicked on the keyboard.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // We close the keyboard.
        searchBar.resignFirstResponder()
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
            
            self.attachTableView()
        default:
            self.stopLoaderAndRefreshViewAnimation()
            self.attachErrorView()
        }
    }
    
    // MARK: View Methods
    /// View Methods
    // Setup this class as a Subsriber.
    func setupSubscriber() {
        Publisher.instance.subscribe(subscriber: self)
    }
    
    // Setup the RefreshController
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: AppString.refreshText)
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        myTableView.addSubview(refreshControl)
    }
    
    // Execute this method when we pull to refresh the view
    @objc func refresh(){
        fetchData()
    }
    
    // Setup the Table View for displaying table data.
    func setupTableView() {
        myTableView = UITableView(frame: view.frame)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier: ProductListingTableItem.identifer)
        myTableView.showsVerticalScrollIndicator = true
        myTableView.contentInset = UIEdgeInsets(top: 39,left: 0,bottom: 0,right: 0)
        myTableView.separatorStyle = .none
        myTableView.keyboardDismissMode = .onDrag
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
            self.loader.view.removeFromSuperview()
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // Attach the TableView
    func attachTableView() {
        Task {
            self.myTableView.frame = CGRect(x: 0, y: 153, width: self.view.frame.size.width, height: self.view.frame.size.height - 153)
            self.view.addSubview(self.myTableView)
        }
    }
    
    // Attach the Error View
    func attachErrorView() {
        Task {
            self.loader.view.removeFromSuperview()
            self.view.addSubview(self.errorView.view)
        }
    }
    
    // MARK: UI Methods
    // Perform Filter on the ui data based on the search text.
    func filterData(searchBar: UISearchBar, searchText: String) {
        self.searchDelegate?.searchBar?(searchBar, textDidChange: searchText)
        storeResponse = masterStoreResponse
        myTableView.backgroundView = nil
        if searchText.isEmpty {
            viewModel.store.success = masterStoreResponse
            myTableView.reloadData()
            return
        }
        storeResponse = storeResponse.filter { item in
            return item.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        
        if storeResponse.isEmpty {
            myTableView.backgroundView = emptySearchResultView.view
        }
        myTableView.reloadData()
    }
    
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            await viewModel.getStoreDetails()
        }
    }
    
}
