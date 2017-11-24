//
//  HomeViews .swift
//  Collection
//
//  Created by Serik Seidigalimov on 22.11.2017.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AARatingBar

class HomeView : UIView{
    
    let tableView = UITableView()
    let searchView = UISearchBar()
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(tableView)
        addSubview(searchView)
        setupLayout()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        searchView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self)
            make.height.equalTo(50)
            make.top.equalToSuperview().offset(64)
        }
        tableView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self)
            make.height.equalTo(self)
            make.top.equalTo(searchView.snp.bottom)
        }
    }
}
