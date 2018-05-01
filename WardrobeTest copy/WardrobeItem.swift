//
//  Wardrobe Item.swift
//  WardrobeTest
//
//  Created by Shristi Sharma on 4/23/18.
//  Copyright © 2018 Shristi. All rights reserved.
//

import Foundation
import UIKit

class WardrobeItem {
    
    var wardrobeItemImage: UIImage
    var dateAdded: Date
    var lastUsed: Date!
    
    init() {
        wardrobeItemImage = UIImage(named:"rad hat")!
        dateAdded = Date()
        lastUsed = nil
        print("init was called")
    }
    
    func SetImage(newImage: UIImage){
        wardrobeItemImage = newImage
    }
    
    func GetImage()->UIImage{
        print("got the image!")
        return wardrobeItemImage
    }
    
    func GetDateAdded() -> Date{
        return dateAdded
    }
    
    func SetLastUsed(newLastUsedDate: Date) {
        lastUsed = newLastUsedDate
    }
    
    func GetLastUsed() -> Date{
        return lastUsed
    }
}

var labRat = WardrobeItem()
var theImage = labRat.GetImage()
