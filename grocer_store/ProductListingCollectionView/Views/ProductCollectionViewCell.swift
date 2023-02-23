//
//  ProductCollectionViewCell.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 16/02/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    /// Properties
    /// Unique identifier for the CollectionView Cell
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: UI Elements
    /// UI Elements
    /// Store Item
    var item: Item? {
        didSet {
            itemNameLabel.text = item?.name
            itemPriceLabel.text = item?.price
            
            guard let imageUrl = item?.image else {
                return
            }
            updateImage(imageUrl: imageUrl)
        }
    }
    
    /// Shows the image of the item
    let itemImage = UIImageView()
    
    /// Shows the name of the item
    let itemNameLabel: UILabel = {
        let uiLabel = UILabel()
        // Setting the font of the UILabel
        uiLabel.font = .systemFont(ofSize: 14,weight: .regular)
        return uiLabel
    }()
    
    /// Shows the price of the item
    let itemPriceLabel: UILabel = {
        let uiLabel = UILabel()
        // Setting the font of the UILabel
        uiLabel.font = .systemFont(ofSize: 14,weight: .bold)
        return uiLabel
    }()
    
    // MARK: Lifecycle methods
    // Lifecycle methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        addViews()
    }
    
    // MARK: View Methods
    /// View Methods
    /// Update image
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
                    self?.itemImage.image = UIImage(named: "Phonepe")
                }
            }
        }
    }
    
    /// Add the UI Views
    func addViews() {
        
        // Prevent the view’s autoresizing mask to be translated into
        // Auto Layout constraints.
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the views to the contentView
        contentView.addSubview(itemImage)
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPriceLabel)

        
        NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: itemNameLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: itemPriceLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemNameLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5).isActive = true
        
        // List of all the constraints
//        var constraints: [NSLayoutConstraint] = []
//
//        // Vertical Align the itemImageView from the top with height:80
//        let verticalConstraintForItemImageView = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemImageView(80)]", options: [], metrics: nil, views: viewsDict)
//        constraints += verticalConstraintForItemImageView
//
//        // Vertical Align the itemNameLabel 10px from the itemImageView
//        let verticalConstraintForImageAndName = NSLayoutConstraint.constraints(withVisualFormat: "V:[itemImageView(80)]-10-[itemNameLabel(10)]", options: [], metrics: nil, views: viewsDict)
//        constraints += verticalConstraintForImageAndName
//
//        // Vertical Align the itemPriceLabel 10px from itemNameLabel
//        let verticalConstraintForNameAndPrice = NSLayoutConstraint.constraints(withVisualFormat: "V:[itemNameLabel(10)]-10-[itemPriceLabel(10)]", options: [], metrics: nil, views: viewsDict)
//        constraints += verticalConstraintForNameAndPrice
//
//        // Horizontal Align the itemImageView to the trailing edge of the superview
//        let horizConstraintImage = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[itemImageView(80)]", options: [], metrics: nil, views: viewsDict)
//        constraints += horizConstraintImage
//
//        // Horizontal Align the itemNameLabel to the trailing edge of the superview
//        let horizConstraintName = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[itemNameLabel]", options: [], metrics: nil, views: viewsDict)
//        constraints += horizConstraintName
//
//        // Horizontal Align the itemPriceLabel to the trailing edge of the superview
//        let horizConstraintPrice = NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[itemPriceLabel]", options: [], metrics: nil, views: viewsDict)
//        constraints += horizConstraintPrice
//
//        contentView.addConstraints(constraints)
    }
}
