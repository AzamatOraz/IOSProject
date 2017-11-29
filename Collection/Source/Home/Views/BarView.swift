//
//  BarView.swift
//  Collection
//
//  Created by Aknur Sh on 11/25/17.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import AARatingBar

class BarView : UIView {
    
    
    let titleLabel = UITextView()
    let descLabel = UITextView()
    let avpLabel = UITextView()
    let imgView = UIImageView()
    let ratBar = AARatingBar()
    let submitRank = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(avpLabel)
        addSubview(imgView)
        addSubview(ratBar)
        addSubview(submitRank)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        imgView.backgroundColor = .red
        imgView.snp.makeConstraints { (make) -> Void in
            make.width.equalToSuperview()
            make.height.equalTo(200)
            make.top.equalToSuperview().offset(100)
            
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.left.equalTo(40)
            make.top.equalTo(imgView.snp.bottom)
        }
        descLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        avpLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(100)
            make.left.equalTo(40)
            make.top.equalTo(descLabel.snp.bottom)
            
        }
        
        ratBar.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(avpLabel.snp.bottom)
            
        }
        
        submitRank.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(ratBar.snp.bottom)
            
        }  
    }
}
