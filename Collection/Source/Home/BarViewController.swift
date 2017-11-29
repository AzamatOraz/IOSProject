//
//  BarViewController.swift
//  Collection
//
//  Created by Aknur Sh on 11/25/17.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Kingfisher
import AARatingBar

class BarViewController : UIViewController {
    
    var barView : BarView { return self.view as! BarView }
    
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle!
    let barData = BarColl()
    var postData = [BarColl]()
    var clickBar = String()
    var pic = UIImage()
    var ratingTap = AARatingBar()
    var rating = String()
    
    override func loadView() {
        self.view = BarView()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(HomeViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        setupView()
        barView.submitRank.addTarget(self, action: #selector(rankBar), for: .touchUpInside)
    }
    
    func setupView() {
        barView.ratBar.color = UIColor.red
        
        self.barView.titleLabel.isEditable = false
        self.barView.descLabel.isEditable = false
        self.barView.avpLabel.isEditable = false
        self.barView.submitRank.backgroundColor = .red
        ref = Database.database().reference()
        let itemsRef = ref.child("Bar").child(clickBar)
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            
            let barObject = snapshot.value as? [String: AnyObject]
            self.barData.barName = barObject?["BarName"] as? String ?? ""
            self.barData.barDesc = barObject?["Description"] as? String ?? ""
            self.barData.avp = barObject?["AveragePrice"] as? String ?? ""
            self.barData.imgURL = barObject?["imageUrl"] as? String ?? ""
            
            self.barView.titleLabel.text = self.barData.barName
            self.barView.descLabel.text = self.barData.barDesc
            self.barView.avpLabel.text = self.barData.avp
            let url = URL(string: self.barData.imgURL)
            self.barView.imgView.kf.setImage(with: url as! Resource)
            
            
        })
        { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }
    
    @objc func rankBar(){
        
        rating = "Rating: \(ratingTap.value)"
        ratingTap.ratingDidChange = { ratingValue in
            self.rating = "Rating: \(ratingValue)"
        
            print("Rating Is Empty: ", self.ratingTap.isEmpty)
            
        }
        print(rating)
    }
}

class BarColl {
    var barName = String()
    var barDesc = String()
    var avp = String()
    var imgURL = String()
}

