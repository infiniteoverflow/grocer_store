//
//  ProductListingCollectionView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

class ProductListingCollectionView: UIViewController {
    
    private var button: UIButton {
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        button.setTitle("Test", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.center = view.center
        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        
    }

}
