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
    static let identifer = "ProductListingTableItem"
    
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
                }
            }
        }
    }
    
    let itemImage = UIImageView()
    let itemName = UILabel()
    let itemPrice = UILabel()
    let extraLabel = UILabel()
    let horizontalDivider = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
      }
    
    override func layoutSubviews() {
            
        itemImage.backgroundColor = Utils.hexStringToUIColor(hex: "F6F6F6")
        itemImage.layer.cornerRadius = 8

        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extraLabel.translatesAutoresizingMaskIntoConstraints = false
        
        itemName.font = .systemFont(ofSize: 14,weight: .bold)
        extraLabel.font = .systemFont(ofSize: 12)
        extraLabel.textColor = .gray
        
        horizontalDivider.backgroundColor = .gray
        

        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(extraLabel)
        contentView.addSubview(horizontalDivider)

        let viewsDict = [
            "storeImage" : itemImage,
            "itemName" : itemName,
            "itemPrice" : itemPrice,
            "extra" : extraLabel,
            "horizDivider": horizontalDivider
        ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[storeImage(50)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[extra]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[itemPrice]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[horizDivider(5)]-|", metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[itemName]|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[itemPrice]-[extra]-20-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-10-[horizDivider(>=200)]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
