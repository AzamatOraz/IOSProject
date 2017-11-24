//
//  ListCell.swift
//  Collection
//
//  Created by Serik Seidigalimov on 23.11.2017.
//  Copyright © 2017 Serik Seidigalimov. All rights reserved.
//

import Foundation
import UIKit
import AARatingBar

class ListCell : UITableViewCell {
    @IBOutlet weak var barView: UIImageView!
    @IBOutlet weak var articleLabel: UILabel!
    @IBOutlet weak var ratingBar: AARatingBar!
    
    class func instanceFromNib() -> ListCell {
        
        return UINib(nibName: "ListCell", bundle:  nil).instantiate(withOwner: nil, options: nil)[0] as! ListCell
    }
}
