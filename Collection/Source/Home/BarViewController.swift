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
    var postData = [barColl]()
    var clickBar = String()
    
    override func loadView() {
        self.view = BarView()
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(HomeViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        print(clickBar)
        setupView()
        
    }
    
    func setupView() {
        barView.titleLabel.text = "Write Bar's name"
        barView.descLabel.text = "Write Bar's description"
        barView.avpLabel.text = "Write Bar's average"
        
        barView.imgView.backgroundColor = .black
        
        barView.ratBar.color = UIColor.red
        
        ref = Database.database().reference()
        let itemsRef = ref.child("Bar")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for ingredient in snapshot.children.allObjects as![DataSnapshot]{
                let barObject = ingredient.value as? [String: AnyObject]
                let barName = barObject?["BarName"] as? String ?? ""
                let barDesc = barObject?["Desc"] as? String ?? ""
                let barAvp = barObject?["Avp"] as? String ?? ""
                let barImg = barObject?["img"] as? String ?? nil
                
                self.postData.append(barColl(barName: barName, barDesc: barDesc, avp: barAvp, imgURL: barImg! ))
            }
            
            
        })
        { (error) in
            print(error.localizedDescription)
            
        }
        print(postData)
        
        
    }
    
}

class barColl {
    var barName = String()
    var barDesc = String()
    var avp = String()
    var imgURL = String()
    
    init(barName: String, barDesc: String, avp: String, imgURL: String ) {
        self.barName = barName
        self.barDesc = barDesc
        self.avp = avp
        self.imgURL = imgURL
    }
}

