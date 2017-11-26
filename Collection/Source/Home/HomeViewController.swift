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
        databaseHandle = ref?.child("Bar").observe(.childAdded, with: { (snapshot) in
            
            if let actualPost = snapshot.value as? [String: Any] {
                let getData = actualPost["Bar"] as? String
                
                self.homeView.tableView.reloadData()
            }
        })
    }
    
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.barView.backgroundColor = UIColor.green
        cell.articleLabel.text = postData[indexPath.row]
        cell.ratingBar.color = UIColor.red
        cell.ratingBar.value = 3 
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(BarViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}


