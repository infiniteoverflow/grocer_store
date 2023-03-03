//
//  ProductListingTableView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

/// Defins the table view of the store data
class ProductListingTableView: UIPageViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NetworkDelegate {
    
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
    private var viewModel = ViewModel()
    
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
    
    // Shows the Slider on the screen.
    private let slider = UISlider()
        
    // MARK: Lifecycle methods
    /// Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.networkDelegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailsVC = ItemDetailsViewController()
        itemDetailsVC.item = storeResponse[indexPath.row]
        self.navigationController?.pushViewController(itemDetailsVC, animated: true)
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
    func updateViewWithData(state: NetworkState, extra: Any?) {
        switch state {
        case .loading:
            setupLoader()
        case .success:
            self.stopLoaderAndRefreshViewAnimation()
            
            guard let response = extra as? [Item] else { return }
            self.storeResponse = response
            self.masterStoreResponse = response
            
            self.attachPostDataLoadView()
            // Setup the Slider
        default:
            self.stopLoaderAndRefreshViewAnimation()
            self.attachErrorView()
        }
    }
    
    // MARK: View Methods
    /// View Methods
    // Setup the RefreshController
    func setupRefreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: AppString.refreshText)
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        myTableView.addSubview(refreshControl)
    }
    
    // Add Constraints for the TableView
    func addTableViewConstraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableTopConstraint = NSLayoutConstraint(item: myTableView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150)
        let tableWidthConstraint = NSLayoutConstraint(item: myTableView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([
            tableTopConstraint,
            tableWidthConstraint
        ])
        
        NSLayoutConstraint.activate(self.view.constraints)
    }
    
    // Add Constraints for the Slider
    func addSliderConstraint() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        let sliderTopConstraint = NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: myTableView, attribute: .bottom, multiplier: 1, constant: 10)
        let sliderBottomConstraint = NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
        let sliderLeadingConstraint = NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let sliderTrailingConstraint = NSLayoutConstraint(item: slider, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        self.view.addConstraints([
            sliderTopConstraint,
            sliderBottomConstraint,
            sliderLeadingConstraint,
            sliderTrailingConstraint
        ])
        
        NSLayoutConstraint.activate(self.view.constraints)
    }
    
    // Execute this method when we pull to refresh the view
    @objc func refresh(){
        fetchData()
    }
    
    // Method that listens to the UISlider value changes.
    @objc func sliderOnChange(sender: UISlider) {
        storeResponse = masterStoreResponse
        let newValue = Int(sender.value)
        sender.setValue(Float(newValue), animated: false)
        
        storeResponse = Array(storeResponse.prefix(upTo: newValue))
        
        myTableView.reloadData()
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
    
    func setupSliderView() {
        self.slider.minimumValue = 1
        self.slider.maximumValue = Float(storeResponse.count)
        self.slider.isContinuous = true
        self.slider.addTarget(self, action: #selector(sliderOnChange), for: .valueChanged)
        self.slider.value = Float(storeResponse.count)
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
    func attachPostDataLoadView() {
        Task {
            self.view.addSubview(self.myTableView)
            self.view.addSubview(self.slider)
            
            self.setupSliderView()
            self.addTableViewConstraints()
            self.addSliderConstraint()
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
        
//        self.slider.value = Float(storeResponse.count)
//        self.slider.maximumValue = Float(storeResponse.count)
    }
    
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            await viewModel.getStoreDetails()
        }
    }
    
}
