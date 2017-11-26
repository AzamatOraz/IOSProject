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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(descLabel)
        addSubview(avpLabel)
        addSubview(imgView)
        addSubview(ratBar)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        imgView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(120)
            make.width.equalTo(120)
            make.left.equalTo(20)
            make.top.equalTo(60)
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.left.equalTo(40)
            make.top.equalTo(60)
            make.left.equalTo(imgView.snp.right)
        }
        descLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(imgView.snp.bottom)
        }
        
        avpLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(100)
            make.left.equalTo(20)
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(imgView.snp.right)
        }
        
        ratBar.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.left.equalTo(20)
            make.top.equalTo(descLabel.snp.bottom)
            
        }
        
        
        
    }
}
