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
    static let identifer = ProductTableString.productTableCellIdentifier
    
    // Store the previous image url
    private var prevImageURL = ""
    
    // MARK: UI Elements
    /// UI Elements
    /// Stores the Item data
    var productItem: Item? {
        didSet {
            itemName.text = productItem?.name
            itemPrice.text = productItem?.price?.replacingOccurrences(of: " ", with: "")
            extraLabel.text = productItem?.extra
            mrpLabel.text = ProductTableString.mrp
            
            guard let imageUrl = productItem?.image else {
                return
            }
            
            if prevImageURL != imageUrl {
                prevImageURL = imageUrl
                updateImage(imageUrl: imageUrl)
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
        itemImage.backgroundColor = AppColors.appLightGray
        itemImage.layer.cornerRadius = 20
        itemImage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateImage(imageUrl: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                if let image = UIImage(data: data) {
                    Task {
                        self?.itemImage.image = image
                    }
                }
            } else {
                Task {
                    self?.itemImage.image = UIImage(named: AppAssets.phonePePlaceholder)
                }
            }
        }
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
        
        // Constraints for the Item Image.
        let imageTopConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let imageLeadingConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 34)
        let imageWidthConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let imageHeightConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        
        // Constraints for the Item Name.
        let nameLeadingConstraint = NSLayoutConstraint(item: itemName, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16)
        
        // Constraints for the MRP Label.
        let mrpLeadingConstraint = NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16)
        let mrpTopConstraint = NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        
        // Constraints for the Price.
        let priceLeadingConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mrpLabel, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 2)
        let priceTopConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        
        // Constraint for the UI Divider
        let dividerTopConstraint = NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemPrice, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 14)
        let dividerLeadingConstraint = NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16)
        let dividerTrailingConstraint = NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -34)
        let dividerHeightConstraint = NSLayoutConstraint(item: uiDivider, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 0.5)
        
        // Constraint for the Extra Label
        let extraBottomConstraint = NSLayoutConstraint(item: extraLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: uiDivider, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -14)
        let extraTrailingConstraint = NSLayoutConstraint(item: extraLabel, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -70)
        
        // Activate the constraints.
        NSLayoutConstraint.activate([
            imageTopConstraint,
            imageLeadingConstraint,
            imageWidthConstraint,
            imageHeightConstraint,
            nameLeadingConstraint,
            mrpLeadingConstraint,
            mrpTopConstraint,
            priceTopConstraint,
            priceLeadingConstraint,
            dividerTopConstraint,
            dividerHeightConstraint,
            dividerLeadingConstraint,
            dividerTrailingConstraint,
            extraBottomConstraint,
            extraTrailingConstraint
        ])
    }
}
