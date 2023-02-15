//
//  ViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 13/02/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var cancellable: AnyCancellable?
    
    var viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancellable = viewModel.$store.sink {
            print("\($0.isLoading)")
        }
        
        self.view.backgroundColor = UIColor.red
    }
    
    
}

