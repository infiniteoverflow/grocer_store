//
//  ViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import UIKit
import Combine

class LandingPageViewController: UITabBarController, UITabBarControllerDelegate {
    
    private var cancellable: AnyCancellable?
    
    var viewModel = ViewModel()
    
    private var button: UIButton {
        let button = UIButton(frame: CGRect(x:100,y:100,width: 100,height: 100))
        button.setTitle("LogIn", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.center = view.center
        return button
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            try await ViewModel().getStoreDetails()
        }
        view.backgroundColor = .white
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
    }
    
    @objc func didTapButton() {
        print("Tap")
    }
}


