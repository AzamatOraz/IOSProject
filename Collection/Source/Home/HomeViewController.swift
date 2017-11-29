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
import Kingfisher

class HomeViewController : UIViewController {
    
    var homeView : HomeView { return self.view as! HomeView }
    var ref:DatabaseReference!
    var databaseHandle:DatabaseHandle!
    var postData = [String]()
    var postPostUrl = [String]()
    var postRating = [Int]()
    var imageTap = UIImageView()
    var selectedPost = ""
    var searchActive : Bool = false
    var filtered: [String] = []
    
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
        homeView.searchView.delegate = self
        ref = Database.database().reference()
        
        ref = Database.database().reference()
        let itemsRef = ref.child("Bar")
        itemsRef.observe(DataEventType.value, with: { (snapshot) in
            for barData in snapshot.children.allObjects as! [DataSnapshot]{
                let barObject = barData.value as? [String: AnyObject]
                let barName = barObject?["BarName"] as? String ?? ""
                let rating = barObject?["Rating"] as? Int
                let imageUrl = barObject?["imageUrl"] as? String ?? ""
                
                
                self.postData.append(barName)
                self.postRating.append(rating!)
                self.postPostUrl.append(imageUrl)
            }
            
            self.homeView.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeView.tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }else{
            return postData.count
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        
        if(searchActive){
            cell.articleLabel.text = filtered[indexPath.row]
            return cell
        } else {
            let url = URL(string: postPostUrl[indexPath.row])
            cell.barView.kf.setImage(with: url as? Resource)
            cell.articleLabel.text = postData[indexPath.row]
            cell.articleLabel.textColor = .black
            cell.ratingBar.color = UIColor.red
            cell.ratingBar.value = CGFloat(postRating[indexPath.row])
            cell.ratingBar.isEnabled = false
            
            return cell
        }
        
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BarViewController()
        vc.clickBar = postData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}

extension HomeViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = postData.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(homeView.searchView.text?.isEmpty)!{
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.homeView.tableView.reloadData()
    }
}

