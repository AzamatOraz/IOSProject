//
//  BarViewController.swift
//  Collection
//
//  Created by Aknur Sh on 11/25/17.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class BarViewController : UIViewController {
    
    var barView : BarView { return self.view as! BarView }
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle!
    
    override func loadView() {
        self.view = BarView()
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(HomeViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        setupView()
        
    }
    
    func setupView() {
        barView.titleLabel.text = "Write Bar's name"
        barView.descLabel.text = "Write Bar's description"
        barView.avpLabel.text = "Write Bar's average"
        
        barView.imgView.backgroundColor = .black
        
        barView.ratBar.color = UIColor.red
        
        ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                
            }
        }
        
    }
    
}
