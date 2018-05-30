//
//  TagCell.swift
//  Wardrobe Test 2
//
//  Created by Shristi Sharma on 5/7/18.
//  Copyright © 2018 Shristi. All rights reserved.
//

import Foundation
import UIKit
class TagCell: UICollectionViewCell {
    @IBOutlet weak var tagName: UILabel!
    
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        self.tagName.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.layer.cornerRadius = 4
        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2 }
}
