//
//  ProductListingTableView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit
import Combine

/// Defins the table view of the store data
class ProductListingTableView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    // Defines the table view that renders the API response.
    private var myTableView: UITableView!
    
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    
    // Stores the store items
    private var storeResponse: [Item] = []
    
    private var viewModel = ViewModel()
    
    // Label to show an error message if the API fails
    private var errorLabel: UILabel!
    
    private var loader: LoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModelListener()
        fetchData()
        setupTableView()
        setupErrorLabel()
        setupLoader()
    }
    
    // MARK: Setup Loader
    // Setup the Loader and add it to the subview
    func setupLoader() {
        loader = LoaderView(frame: view.frame)
        view.addSubview(loader.loadingView)
    }
    
    // MARK: Fetch Data
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            try await viewModel.getStoreDetails()
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
                    self.view.addSubview(self.loader.loadingView)
                }
            } else {
                if($0.success != nil) {
                    guard let response = $0.success else { return }
                    self.storeResponse = response
                    Task {
                        self.loader.loadingView.removeFromSuperview()
                        self.myTableView.frame = CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: self.view.frame.size.height - 180)
                        self.view.addSubview(self.myTableView)
                    }
                } else if($0.error != "") {
                    
                    Task {
                        self.loader.stopLoader()
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
