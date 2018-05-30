//
//  FlowLayout.swift
//  Wardrobe Test 2
//
//  Created by Shristi Sharma on 5/7/18.
//  Copyright © 2018 Shristi. All rights reserved.
//

import Foundation
class FlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributesForElementsInRect = super.layoutAttributesForElementsInRect(rect)
        var newAttributesForElementsInRect = [AnyObject]()
        // use a value to keep track of left margin
        var leftMargin: CGFloat = 0.0;
        for attributes in attributesForElementsInRect! {
            var refAttributes = attributes as! UICollectionViewLayoutAttributes
            // assign value if next row
            if (refAttributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                // set x position of attributes to current margin
                var newLeftAlignedFrame = refAttributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                refAttributes.frame = newLeftAlignedFrame
            }
            // calculate new value for current margin
            leftMargin += refAttributes.frame.size.width
            newAttributesForElementsInRect.append(refAttributes)
        }
        return newAttributesForElementsInRect
    }
}
/*
Back to our `ViewController.swift`, we create a cell for calculating cell width based on tag length:
*/
var sizingCell: TagCell?
/*
In `viewDidLoad` method, we create this cell based on our already created nib:
*/
self.sizingCell = (cellNib.instantiateWithOwner(nil, options: nil) as NSArray).firstObject as! TagCell?
/*
Then override `sizeForItemAtIndexPath` method of `UICollectionViewFlowLayout`. This should create correct size for our cell:
*/
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    self.configureCell(self.sizingCell!, forIndexPath: indexPath)
    return self.sizingCell!.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
}
/*
Run project again, and this should be result:

[![FlowLayout_NextResult](/content/images/2015/07/FlowLayout_NextResult-361x640.png)](/content/images/2015/07/FlowLayout_NextResult.png)

It seems almost correct, we will add more horizontal spacing and inset to our collectionView later.

## Horizontal Spacing

Drag an Outlet from our Flow Layout inside storyboard to our `ViewController`:

[![FlowLayout_OutletLayout](/content/images/2015/07/FlowLayout_OutletLayout-640x295.png)](/content/images/2015/07/FlowLayout_OutletLayout.png)

Back to our `ViewController.swift`, set a `sectionInset` to our flowLayout in `viewDidLoad`:
*/

self.flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
/*
Switch to our `FlowLayout.swift`, we will add a horizontal spacing value when recalculating `rightMargin`, change:
*/
leftMargin += refAttributes.frame.size.width
/*
to:
*/
leftMargin += refAttributes.frame.size.width + 8
/*
Then, our result should looks like this:

[![FlowLayout_DoneResult](/content/images/2015/07/FlowLayout_DoneResult-361x640.png)](/content/images/2015/07/FlowLayout_DoneResult.png)

## Customize Selection

You may want to custom tag selection at this step. To do this, we should create a separate model class for the tag, which hold a name and a `Boolean` flag indicates if the tag is selected:
*/
class Tag { var name: String? var selected = false }
/*
We can loop through predefined tags and create an array of Tag:
*/
var tags = [Tag]()

override func viewDidLoad() {
    ...
    for name in TAGS {
        var tag = Tag()
        tag.name = name
        self.tags.append(tag)
    }
}
/*
Then we change our `dataSource` function like this:
*/
func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tags.count
}

func configureCell(cell: TagCell, forIndexPath indexPath: NSIndexPath) {
    let tag = tags[indexPath.row]
    cell.tagName.text = tag.name
    cell.tagName.textColor = tag.selected ? UIColor.whiteColor() : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    cell.backgroundColor = tag.selected ? UIColor(red: 0, green: 1, blue: 0, alpha: 1) : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
}
/*
Finally, add method to select a tag:
*/
func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    tags[indexPath.row].selected = !tags[indexPath.row].selected
    self.collectionView.reloadData()
}
/*
And result:

[![FlowLayout_FinalResult](/content/images/2015/07/FlowLayout_FinalResult-361x640.png)](/content/images/2015/07/FlowLayout_FinalResult.png)

Now, all customizations like color, size and spacing are your! Please refer to source code at [GitHub](https://github.com/moonlsd/TagFlowExample). Leave comment here or email me if you still have concern.
*/
