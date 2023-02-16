//
//  LoaderView.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 15/02/23.
//

import UIKit

/// Shows a UIActivityIndicatorView and handles all the internal setup.
class LoaderView: UIView {
    var loadingView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadingView = UIActivityIndicatorView(frame: frame)
        loadingView.color = .systemGray
        loadingView.style = .large
        loadingView.startAnimating()
        self.startLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func startLoader() {
        loadingView.startAnimating()
    }
    
    func stopLoader() {
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()
    }
}
