//
//  EmptyViewController.swift
//  grocer_store
//
//  Created by Aswin Gopinathan on 22/02/23.
//

import UIKit

class EmptyViewController: UIViewController {
    
    let redBox = UIView()
    let orangeBox = UIView()
    let grayBox = UIView()
    
    let box1 = UIView()
    let box2 = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(redBox)
        view.addSubview(orangeBox)
        view.addSubview(grayBox)
        self.grayBox.addSubview(box1)
        self.grayBox.addSubview(box2)
        
//        self.grayBox.addSubview(box1)
//        self.grayBox.addSubview(box2)
        
        redBox.translatesAutoresizingMaskIntoConstraints = false
        orangeBox.translatesAutoresizingMaskIntoConstraints = false
        grayBox.translatesAutoresizingMaskIntoConstraints = false
        
        box1.translatesAutoresizingMaskIntoConstraints = false
        box2.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        redBox.backgroundColor = .red
        orangeBox.backgroundColor = .orange
        grayBox.backgroundColor = .gray
        box1.backgroundColor = .white
        box2.backgroundColor = .yellow
        
        let topcons = NSLayoutConstraint(item: redBox, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let leadingcons = NSLayoutConstraint(item: redBox, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let trailingcons = NSLayoutConstraint(item: redBox, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)

        let heightcons = NSLayoutConstraint(item: redBox, attribute: .height, relatedBy: .equal, toItem: grayBox, attribute: .height, multiplier: 1, constant: 0)

//        NSLayoutConstraint(item: squareBox, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40).isActive = true
        
        self.view.addConstraint(topcons)
        self.view.addConstraint(leadingcons)
        self.view.addConstraint(trailingcons)
        self.view.addConstraint(heightcons)
        

        
//        self.view = view
        
//        NSLayoutConstraint.activate(self.view.constraints)
        
        
        
        
        
        let bottomOrange = NSLayoutConstraint(item: orangeBox, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let trailingOrange = NSLayoutConstraint(item: orangeBox, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingOrange = NSLayoutConstraint(item: orangeBox, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let heightOrange = NSLayoutConstraint(item: orangeBox, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)
        
        self.view.addConstraint(bottomOrange)
        self.view.addConstraint(trailingOrange)
        self.view.addConstraint(leadingOrange)
        self.view.addConstraint(heightOrange)
                
        
        let topGray = NSLayoutConstraint(item: grayBox, attribute: .top, relatedBy: .equal, toItem: redBox, attribute: .bottom, multiplier: 1, constant: 0)
        let bottomGray = NSLayoutConstraint(item: grayBox, attribute: .bottom, relatedBy: .equal, toItem: orangeBox, attribute: .top, multiplier: 1, constant: 0)
        let trailingGray = NSLayoutConstraint(item: grayBox, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingGray = NSLayoutConstraint(item: grayBox, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        self.view.addConstraint(topGray)
        self.view.addConstraint(bottomGray)
        self.view.addConstraint(trailingGray)
        self.view.addConstraint(leadingGray)
                
        
        
        let box1Leading = NSLayoutConstraint(item: box1, attribute: .leading, relatedBy: .equal, toItem: grayBox, attribute: .leading, multiplier: 1, constant: 10)
        let box1Trailing = NSLayoutConstraint(item: box1, attribute: .trailing, relatedBy: .equal, toItem: grayBox, attribute: .trailing, multiplier: 0.5, constant: 0)
        let box1Top = NSLayoutConstraint(item: box1, attribute: .top, relatedBy: .equal, toItem: grayBox, attribute: .top, multiplier: 1, constant: 10)
        let box1Bottom = NSLayoutConstraint(item: box1, attribute: .bottom, relatedBy: .equal, toItem: grayBox, attribute: .bottom, multiplier: 1, constant: -10)
        
        self.view.addConstraint(box1Leading)
        self.view.addConstraint(box1Trailing)
        self.view.addConstraint(box1Top)
        self.view.addConstraint(box1Bottom)
        
        let box2Leading = NSLayoutConstraint(item: box2, attribute: .leading, relatedBy: .equal, toItem: box1, attribute: .trailing, multiplier: 1, constant: 10)
        let box2Trailing = NSLayoutConstraint(item: box2, attribute: .trailing, relatedBy: .equal, toItem: grayBox, attribute: .trailing, multiplier: 1, constant: -10)
        let box2Top = NSLayoutConstraint(item: box2, attribute: .top, relatedBy: .equal, toItem: grayBox, attribute: .top, multiplier: 1, constant: 10)
        let box2Bottom = NSLayoutConstraint(item: box2, attribute: .bottom, relatedBy: .equal, toItem: grayBox, attribute: .bottom, multiplier: 1, constant: -10)
        
        self.view.addConstraint(box2Leading)
        self.view.addConstraint(box2Trailing)
        self.view.addConstraint(box2Top)
        self.view.addConstraint(box2Bottom)
        
        NSLayoutConstraint.activate(self.view.constraints)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
