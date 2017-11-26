//
//  ComposeView.swift
//  Collection
//
//  Created by Aknur Sh on 11/24/17.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ComposeView : UIView {
    
    //let tableView = UITableView()
    let titleLabel = UILabel()
    let titleText = UITextView()
    let descLabel = UILabel()
    let descText = UITextView()
    let avpLabel = UILabel()
    let avpText = UITextField() 
    let imgBtn = UIButton()
    let imgView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(titleText)
        addSubview(descLabel)
        addSubview(descText)
        addSubview(avpLabel)
        addSubview(avpText)
        addSubview(imgBtn)
        addSubview(imgView)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(60)
        }
        titleText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        descLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(titleText.snp.bottom)
        }
        descText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(120)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(descLabel.snp.bottom)
        }
        avpLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(descText.snp.bottom)
        }
        avpText.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.left.equalTo(20)
            make.top.equalTo(avpLabel.snp.bottom)
        }
        imgBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(200)
            make.left.equalTo(20)
            make.top.equalTo(avpText.snp.bottom)
        }
        
        imgView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(70)
            make.width.equalTo(70)
            make.left.equalTo(20)
            make.top.equalTo(imgBtn.snp.bottom)
        }
    }    
}
