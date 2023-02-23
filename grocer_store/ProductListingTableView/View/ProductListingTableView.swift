//
//  ProductListingTableView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit
import Combine

/// Defins the table view of the store data
class ProductListingTableView: UIPageViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: Properties
    /// Properties
    /// List of properties used by the controller
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    
    /// Delegate for passing the search data to another view
    var searchDelegate: UISearchBarDelegate? = nil
    
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
    
    // Label to show an error message if the API fails
    private var errorLabel: UILabel!
    
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
        attachViewModelListener()
        fetchData()
        setupTableView()
        setupErrorLabel()
        setupRefreshController()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    
    // Setup the RefreshController
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        myTableView.addSubview(refreshControl)
    }
    
    /// Execute this method when we pull to refresh the view
    @objc func refresh(){
        fetchData()
    }
    
    // MARK: Fetch Data
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            await viewModel.getStoreDetails()
        }
    }
    
    // MARK: Setup TableView
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
    
    // MARK: Setup Error Label
    // Setup the Error Label to show any error messages
    func setupErrorLabel() {
        errorLabel = UILabel(frame: self.view.frame)
        errorLabel.text = "Something went wrong, \nPlease try again later"
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        errorLabel.numberOfLines = 2
    }
    
    // MARK: Attach ViewModel Listener
    // Attach listeners to listen to the Network call
    // to fetch store data.
    func attachViewModelListener() {
        cancellable = viewModel.$store.sink {
            if($0.isLoading == true) {
                Task {
                    if !self.refreshControl.isRefreshing {
                        self.view.addSubview(self.loader.view)
                    }
                }
            } else {
                Task {
                    self.loader.view.removeFromSuperview()
                    if self.refreshControl.isRefreshing {
                        self.refreshControl.endRefreshing()
                    }
                }
                if($0.success != nil) {
                    guard let response = $0.success else { return }
                    self.storeResponse = response
                    self.masterStoreResponse = response
                    Task {
                        self.myTableView.frame = CGRect(x: 0, y: 153, width: self.view.frame.size.width, height: self.view.frame.size.height - 153)
                        self.view.addSubview(self.myTableView)
                    }
                } else if($0.error != "") {
                    
                    Task {
                        self.view.addSubview(self.errorLabel)
                    }
                }
            }
        }
    }
    
    // MARK: TableView-NumberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storeResponse.count
    }
    
    // MARK: TableView-cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListingTableItem.identifer, for: indexPath) as! ProductListingTableItem
        cell.productItem = storeResponse[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
