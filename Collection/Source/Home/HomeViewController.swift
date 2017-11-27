//
//  HomeViewController.swift
//  Collection
//
//  Created by Serik Seidigalimov on 22.11.2017.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import AARatingBar
import FirebaseDatabase

class HomeViewController : UIViewController {
    
    var homeView : HomeView { return self.view as! HomeView }
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle!
    var postData = [String]()
    var postImage = [UIImage]()
    var selectedPost = ""
    
    override func loadView() {
        self.view = HomeView()
    }
    
    override func viewDidLoad() {
        title = "Bar&Pub"
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(HomeViewController.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        setupTableView()
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        navigationController?.pushViewController(ComposeViewController(), animated: true)
    }
    
    func setupTableView() {
        homeView.tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "Cell")
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
        ref = Database.database().reference()
        
//        ref.observe(DataEventType.value, with: { (snapshot) in
//
//            //if the reference have some values
//            if snapshot.childrenCount > 0 {
//
//                //clearing the list
//                self.postData.removeAll()
//
//                //iterating through all the values
//                for bars in snapshot.children.allObjects as! [DataSnapshot] {
//
//
//                    if let post = snapshot.value as? String  {
//                        self.postData.append(actualPost)
//
//                    }
//                }
//
//                //reloading the tableview
//                self.homeView.tableView.reloadData()
//            }
//        })
//
//        databaseHandle = ref?.child("Bar").observe(.childAdded, with: { (snapshot) in
//
//
//        })
        
        ref = Database.database().reference()
        let itemsRef = ref.child("Bar")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for barData in snapshot.children.allObjects as![DataSnapshot]{
                let barObject = barData.value as? [String: AnyObject]
                let barName = barObject?["BarName"] as? String ?? ""
                let imageUrl = barObject?["imageUrl"] as? String ?? ""
                self.postData.append(barName)
                self.getImage(str: imageUrl)
            }
            
            self.homeView.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            
        }
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
                            self.postImage.append(image!)
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
    }
    
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.barView.image = postImage[indexPath.row]
        cell.articleLabel.text = postData[indexPath.row]
        cell.articleLabel.textColor = .black
        cell.ratingBar.color = UIColor.red
        cell.ratingBar.value = 3 
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BarViewController()
        
        vc.clickBar = postData[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
//        selectedPost = postData[indexPath.row]
//        self.performSegue(withIdentifier: "go", sender: indexPath)
//        navigationController?.pushViewController(BarViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}


