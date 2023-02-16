//
//  ProductListingCollectionView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit
import Combine

class ProductListingCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Defines a cancellable object to retrieve the
    // state of the Network call.
    private var cancellable: AnyCancellable?
    
    private var viewModel = ViewModel()
    
    // Stores the store items
    private var storeResponse: [Item] = []
    
    private var loader: LoaderView!
    
    // Label to show an error message if the API fails
    private var errorLabel: UILabel!
    
    var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachViewModelListener()
        setupLoader()
        setupErrorLabel()
        setupCollectionView()
        fetchData()
    }
    
    // MARK: Setup Collection View
    // Setup the Collection View to show the grid of store items.
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionview.backgroundColor = .white
        collectionview.contentInset = UIEdgeInsets(top: 39, left: 20, bottom: 10,right: 0)
    }
    
    // MARK: Setup Loader
    // Setup the Loader and add it to the subview
    func setupLoader() {
        loader = LoaderView(frame: view.frame)
        view.addSubview(loader.loadingView)
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
    
    // MARK: Fetch Data
    // Perfrom Network call to fetch Store Data.
    func fetchData() {
        Task {
            try await viewModel.getStoreDetails()
        }
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
                    guard let response = $0.success else {return}
                    self.storeResponse = response.data.items
                    Task {
                        self.collectionview.frame = CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: self.view.frame.size.height - 180)
                        self.view.addSubview(self.collectionview)
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
    
}
