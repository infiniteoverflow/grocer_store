//
//  AppFilterViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 05/03/23.
//

import UIKit

class AppFilterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    // Properties
    private var filterTexts = [
        "Sort by Name",
        "Sort by Price",
        "Show with Same Day Shipping",
    ]
    
    // MARK: UI Views
    // UI Views
    // Used for displaying the table view of all the
    // available filters.
    private var filterTableView: UITableView!
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 200)
        setupTableView()
        view.addSubview(filterTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterVC", for: indexPath)
        cell.textLabel?.text = filterTexts[indexPath.row]
        return cell
    }
    
    // MARK: View Methods
    // Setup the Table View for displaying table data.
    func setupTableView() {
        filterTableView = UITableView(frame: view.frame)
        filterTableView.dataSource = self
        filterTableView.delegate = self
        filterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilterVC")
        filterTableView.showsVerticalScrollIndicator = true
        filterTableView.contentInset = UIEdgeInsets(top: 39,left: 0,bottom: 0,right: 0)
        filterTableView.separatorStyle = .singleLine
        filterTableView.keyboardDismissMode = .onDrag
    }
}
