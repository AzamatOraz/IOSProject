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

class BarViewController : UIViewController {
    
    var barView : BarView { return self.view as! BarView }
    
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle!
    let barData = BarColl()
    var postData = [BarColl]()
    var clickBar = String()
    var pic = UIImage()
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
    
    func getImage(str: String) {
        
        let catPictureURL = URL(string: str)!
        
        // Creating a session object with the default configuration.
        // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                           self.barView.imgView.image = image
                        }
                        
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
        
        
//        ref = Database.database().reference()
//        let storage = Storage.storage()
//        var storageRef = storage.reference()
//        let itemsRef = ref.child("Bar").child(clickBar)
//        itemsRef.observe(DataEventType.value, with: { (snapshot) in
//            // Get download URL from snapshot
//            let barImage = snapshot.value as? [String: AnyObject]
//            let downloadURL = barImage?["imageUrl"] as? String ?? ""
//            // Create a storage reference from the URL
//            storageRef = storage.reference(forURL: downloadURL)
//            // Download the data, assuming a max size of 1MB (you can change this as necessary)
//            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                if let error = error {
//                    // Uh-oh, an error occurred!
//                } else {
//                    // Data for "images/island.jpg" is returned
//                    self.pic = UIImage(data: data!)!
//                }
//            }
//        })
    }
    
    func setupView() {
        barView.ratBar.color = UIColor.red
        self.barView.titleLabel.isEditable = false
        self.barView.descLabel.isEditable = false
        self.barView.avpLabel.isEditable = false
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
            self.getImage(str: self.barData.imgURL)
            
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
}

class BarColl {
    var barName = String()
    var barDesc = String()
    var avp = String()
    var imgURL = String()
}

