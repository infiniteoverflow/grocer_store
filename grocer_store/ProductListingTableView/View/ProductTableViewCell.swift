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
            itemPrice.text = productItem?.price?.replacingOccurrences(of: " ", with: "")
            extraLabel.text = productItem?.extra
            mrpLabel.text = "MRP:"
            
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
                        self?.itemImage.image = UIImage(named: "Phonepe")
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
    // Shows the "MRP" tag
    let mrpLabel = UILabel()
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
        uiDivider.backgroundColor = .gray.withAlphaComponent(0.3)
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
        // Determines whether the view’s autoresizing mask
        // is translated into Auto Layout constraint.
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extraLabel.translatesAutoresizingMaskIntoConstraints = false
        mrpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Defines the font for the labels.
        itemName.font = .systemFont(ofSize: 14,weight: .bold)
        extraLabel.font = .systemFont(ofSize: 12)
        mrpLabel.font = .systemFont(ofSize: 14)
        itemPrice.font = .systemFont(ofSize: 14)
                
        // Defines the textcolor for the labels.
        extraLabel.textColor = .gray
        mrpLabel.textColor = .gray
    }
    
    // MARK: Setup Subviews
    // Add subviews
    func addSubviews() {
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(extraLabel)
        contentView.addSubview(mrpLabel)
        contentView.addSubview(uiDivider)
    }
    
    // MARK: Add Constaints
    // Add the constraints
    func addConstraints() {
        
        NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 34).isActive = true
        
        NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50).isActive = true

        NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: itemName, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        
        NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        
        NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mrpLabel, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 2).isActive = true
        
        NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemPrice, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 14).isActive = true
        
        NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16).isActive = true
        
        NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -34).isActive = true
        
        NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0.5).isActive = true
        
        NSLayoutConstraint(item: extraLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: uiDivider, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -14).isActive = true
        
        NSLayoutConstraint(item: extraLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -70).isActive = true
    }
}
