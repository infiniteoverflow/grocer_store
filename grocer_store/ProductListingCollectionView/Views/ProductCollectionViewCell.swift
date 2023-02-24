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
    static let identifier = ProductCollectionString.productCollectionCellIdentifier
    
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
                    self?.itemImage.image = UIImage(named: AppAssets.phonePePlaceholder)
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
    }
}
