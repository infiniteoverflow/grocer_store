//
//  ItemDetailsViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 27/02/23.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: Properties
    // Properties
    /// Item data
    var item: Item? {
        didSet {
            itemName.text = item?.name
            itemPrice.text = item?.price?.replacingOccurrences(of: " ", with: "")
            extraLabel.text = item?.extra
            mrpLabel.text = ProductTableString.mrp
            
            guard let imageUrl = item?.image else {
                return
            }
            
            updateImage(imageUrl: imageUrl)
        }
    }
    
    // MARK: View Properties
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImage()
        setupLabels()
        addSubviews()
        addConstraints()
    }
    
    // MARK: Setup Image
    // Setup the image
    func setupImage() {
        itemImage.backgroundColor = AppColors.appLightGray
        itemImage.layer.cornerRadius = 20
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
        view.addSubview(itemImage)
        view.addSubview(itemName)
        view.addSubview(itemPrice)
        view.addSubview(extraLabel)
        view.addSubview(mrpLabel)
    }
    
    // MARK: Add Constaints
    // Add the constraints
    func addConstraints() {
        
        // Constraints for the Item Image.
        let imageTopConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 100)
        let imageLeadingConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 34)
        let imageTrailingConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 34)
        let imageWidthConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        let imageHeightConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        
        // Constraints for the Item Name.
        let nameLeadingConstraint = NSLayoutConstraint(item: itemName, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16)
        
        // Constraints for the MRP Label.
        let mrpLeadingConstraint = NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 16)
        let mrpTopConstraint = NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        
        // Constraints for the Price.
        let priceLeadingConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mrpLabel, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 2)
        let priceTopConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)

        
        self.view.addConstraints([
            imageTopConstraint,
            imageTrailingConstraint,
            imageLeadingConstraint,
            imageWidthConstraint,
            imageHeightConstraint,
            nameLeadingConstraint,
            mrpLeadingConstraint,
            mrpTopConstraint,
            priceTopConstraint,
            priceLeadingConstraint,
        ])
        
        // Activate the constraints.
        NSLayoutConstraint.activate(self.view.constraints)
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

}
