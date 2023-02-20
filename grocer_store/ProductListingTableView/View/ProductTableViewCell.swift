//
//  ProductTableViewCell.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

import Foundation
import UIKit

class ProductListingTableItem : UITableViewCell {
    
    // MARK: Properties
    /// Properties
    /// Unique identifier for the Table Cell
    static let identifer = "ProductListingTableItem"
    
    // MARK: UI Elements
    /// UI Elements
    /// Stores the Item data
    var productItem: Item? {
        didSet {
            itemName.text = productItem?.name
            itemPrice.text = productItem?.price
            extraLabel.text = productItem?.extra
            
            guard let imageUrl = productItem?.image else {
                return
            }
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                    if let image = UIImage(data: data) {
                        Task {
                            self?.itemImage.image = image
                        }
                    }
                } else {
                    Task {
                        self?.itemImage.image = UIImage(named: "Placeholder")
                    }
                }
            }
        }
    }
    
    // Stores the item image.
    let itemImage = UIImageView()
    // Stores the item name.
    let itemName = UILabel()
    // Stores the item price.
    let itemPrice = UILabel()
    // Stores the extra data regarding the item.
    let extraLabel = UILabel()
    // Shows the Divider between cells.
    let uiDivider = UIView()
    
    
    // MARK: Lifecycle methods
    /// Lifecycle methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Layout the subviews
    override func layoutSubviews() {
        setupImage()
        setupDivider()
        setupLabels()
        addSubviews()
        addConstraints()
    }
    
    
    // MARK: View methods
    /// View methods
    /// Setup the Divider between the cells
    func setupDivider() {
        uiDivider.translatesAutoresizingMaskIntoConstraints = false
        uiDivider.backgroundColor = .gray
    }
    
    // MARK: Setup Image
    // Setup the image
    func setupImage() {
        itemImage.backgroundColor = Utils.hexStringToUIColor(hex: "F6F6F6")
        itemImage.layer.cornerRadius = 8
        itemImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Setup Labels
    // Setup the labels
    func setupLabels() {
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extraLabel.translatesAutoresizingMaskIntoConstraints = false
        
        itemName.font = .systemFont(ofSize: 14,weight: .bold)
        extraLabel.font = .systemFont(ofSize: 12)
        extraLabel.textColor = .gray
    }
    
    // MARK: Setup Subviews
    // Add subviews
    func addSubviews() {
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(extraLabel)
        contentView.addSubview(uiDivider)
    }
    
    // MARK: Add Constaints
    // Add the constraints
    func addConstraints() {
        
        // Dictionary of Views with their keys.
        let viewsDict = [
            "storeImage" : itemImage,
            "itemName" : itemName,
            "itemPrice" : itemPrice,
            "extra" : extraLabel,
            "divider": uiDivider
        ] as [String : Any]
        
        // List of constraints.
        var constraints: [NSLayoutConstraint] = []
        
        // Vertical Align the Item Image.
        let verticalAlignImage = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[storeImage(50)]", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignImage
        
        // Vertical Align the Extra Text.
        let verticalAlignExtra = NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[extra]", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignExtra
        
        // Vertical Align Name and Price Relative to each other.
        let verticalAlignNameAndPrice = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[itemPrice]", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignNameAndPrice
        
        // Vertical Align Divider.
        let verticalAlignDivider = NSLayoutConstraint.constraints(withVisualFormat: "V:[itemPrice]-[divider(0.5)]", options: [], metrics: nil, views: viewsDict)
        constraints += verticalAlignDivider
        
        // Horizontal Align the Image and Name Relative to each other.
        let horizAlignImageAndName = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[itemName]|", options: [], metrics: nil, views: viewsDict)
        constraints += horizAlignImageAndName
        
        // Horizontal Align Divider.
        let horizAlignDivider = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[divider]|", options: [], metrics: nil, views: viewsDict)
        constraints += horizAlignDivider
        
        // Horizontal Align Image, Price, and Extra labels relative to each other.
        let horizAlignImagePriceAndExtra = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[itemPrice]-[extra]-20-|", options: [], metrics: nil, views: viewsDict)
        constraints += horizAlignImagePriceAndExtra
        
        // Add all the constraints to the ContentView
        contentView.addConstraints(constraints)
    }
}
