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

class HomeViewController : UIViewController {
    
    var homeView : HomeView { return self.view as! HomeView }
    
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
    }
    
}
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        cell.barView.backgroundColor = UIColor.green
        cell.articleLabel.text = "Bar # \(indexPath.row)"
        cell.ratingBar.color = UIColor.red
        cell.ratingBar.value = 3 
        return cell
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
}


