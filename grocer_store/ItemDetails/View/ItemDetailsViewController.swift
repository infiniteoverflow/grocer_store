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
    // Shows the Close Button for CollectionView Data
    let closeButton = UIButton(type: .close)
    
    // MARK: Class Properties
    // Class Properties
    var fromTableView = true
    
    // Defines the AspectRatio of the Item Image.
    private var imageAspectRatio: CGFloat = 0.0
    
    override func viewDidLoad() {
        // Show the navigation bar when the view is loaded.
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Hide the navigation bar when the view is being removed.
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        setupImage()
        setupLabels()
        setupCloseButton()
        
        addSubviews()
    }
    
    // MARK: Setup the Close Button
    // Setup the Close Button
    func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup the Tap Gesture Recognizer.
        closeButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCloseTap))
        closeButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: Setup Image
    // Setup the image
    func setupImage() {
        itemImage.backgroundColor = .clear
        itemImage.layer.cornerRadius = 80
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemImage.accessibilityIdentifier = "ItemImage"
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
        
        // Define the identifiers for the labels
        itemName.accessibilityIdentifier = "ItemName"
        itemPrice.accessibilityIdentifier = "ItemPrice"
        extraLabel.accessibilityIdentifier = "ExtraLabel"
        mrpLabel.accessibilityIdentifier = "MRPLabel"
        
        // Defines the font for the labels.
        itemName.font = .systemFont(ofSize: 14,weight: .bold)
        extraLabel.font = .systemFont(ofSize: 12)
        mrpLabel.font = .systemFont(ofSize: 14)
        itemPrice.font = .systemFont(ofSize: 14)
        
        // Defines the alignment for the labels
        itemName.textAlignment = .center
        mrpLabel.textAlignment = .right
        extraLabel.textAlignment = .center
        
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
        
        // Dont add the Close button if the view was opened
        // from the TableView.
        if !fromTableView {
            view.addSubview(closeButton)
        }
    }
    
    // MARK: Add Constaints
    // Add the constraints
    func addConstraints() {
        if imageAspectRatio == 0.0 {
            return
        }
        // Constraints for the Item Image.
        setImageConstraints()
        // Constraints for the Item Name.
        setNameConstraints()
        // Constraints for the MRP Label.
        setMrpConstraints()
        // Constraints for the Item Price.
        setPriceConstraints()
        // Constraints for the Extra Label.
        setExtraLabelConstraints()
        // Constraints for the Close Button
        if !fromTableView {
            setCloseConstraints()
        }
        
        // Activate the constraints.
        NSLayoutConstraint.activate(self.view.constraints)
    }
    
    // Constraints for the close button
    func setCloseConstraints() {
        let closeTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10)
        let closeTrailingConstraint = NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10)
        
        self.view.addConstraints([
            closeTopConstraint,
            closeTrailingConstraint,
        ])
    }
    
    // Constraints for the extra label
    func setExtraLabelConstraints() {
        let extraTopConstraint = NSLayoutConstraint(item: extraLabel, attribute: .top, relatedBy: .equal, toItem: mrpLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let extraLeadingConstraint = NSLayoutConstraint(item: extraLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let extraTrailingConstraint = NSLayoutConstraint(item: extraLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.view.addConstraints([
            extraTopConstraint,
            extraLeadingConstraint,
            extraTrailingConstraint
        ])
    }
    
    // Constraints for the Item Price.
    func setPriceConstraints() {
        let priceLeadingConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mrpLabel, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 2)
        let priceTopConstraint = NSLayoutConstraint(item: itemPrice, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        
        self.view.addConstraints([
            priceLeadingConstraint,
            priceTopConstraint,
        ])
    }
    
    // Constraints for the MRP Label
    func setMrpConstraints() {
        let mrpTopConstraint = NSLayoutConstraint(item: mrpLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemName, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 8)
        let mrpLeadingConstraint = NSLayoutConstraint(item: mrpLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let mrpTrailingConstraint = NSLayoutConstraint(item: mrpLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 0.49, constant: 0)
        
        self.view.addConstraints([
            mrpTopConstraint,
            mrpLeadingConstraint,
            mrpTrailingConstraint
        ])
    }
    
    // Constraints for the Item Name.
    func setNameConstraints() {
        let nameTopConstraint = NSLayoutConstraint(item: itemName, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: itemImage, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 16)
        let nameLeadingConstraint = NSLayoutConstraint(item: itemName, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let nameTrailingConstraint = NSLayoutConstraint(item: itemName, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        self.view.addConstraints([
            nameTopConstraint,
            nameLeadingConstraint,
            nameTrailingConstraint
        ])

    }
    
    // Define constraints for the Item Image
    func setImageConstraints() {
        // Constraints for the Item Image.
        let imageTopConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 100)
        let imageLeadingConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10)
        let imageTrailingConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10)
        
        let imageHeightConstraint = NSLayoutConstraint(item: itemImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: (view.frame.width-20)/imageAspectRatio)
        
        self.view.addConstraints([
            imageTopConstraint,
            imageHeightConstraint,
            imageLeadingConstraint,
            imageTrailingConstraint
        ])
    }
    
    func updateImage(imageUrl: String) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                if let image = UIImage(data: data) {
                    Task {
                        self?.itemImage.image = image
                        self?.imageAspectRatio = (self?.itemImage.image?.size.width ?? 1) / (self?.itemImage.image?.size.height ?? 1)
                        self?.addConstraints()
                    }
                    
                }
            } else {
                Task {
                    self?.itemImage.image = UIImage(named: AppAssets.phonePePlaceholder)
                    self?.imageAspectRatio = (self?.itemImage.image?.size.width ?? 1) / (self?.itemImage.image?.size.height ?? 1)
                    self?.addConstraints()
                }
            }
        }
    }
    
    // Close Button Tap Gesture Recognizer action
    @objc func onCloseTap() {
        self.dismiss(animated: true)
    }
    
}
