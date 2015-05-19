//
//  MulpleLineLayout.swift
//  SampleInfinityCollectionView
//
//  Created by nagisa-kosuge on 2015/05/19.
//  Copyright (c) 2015年 RyoKosuge. All rights reserved.
//

import UIKit

class MultipleLineLayout: UICollectionViewFlowLayout {
    
    var itemHeight: Int
    var itemWidth: Int
    var space: Int
    
    init(itemHeight:Int, itemWidth: Int, space: Int) {
        
        self.itemHeight = itemHeight
        self.itemWidth = itemWidth
        self.space = space
        
        super.init()
        scrollDirection = .Horizontal
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionViewContentSize() -> CGSize {
        if let collectionView = collectionView {
            let xSize = collectionView.numberOfItemsInSection(0) * (itemWidth + space)
            let ySize = collectionView.numberOfSections() * (itemHeight + space)
            return CGSize(width: xSize, height: ySize)
        }
        return CGSizeZero
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.size = CGSize(width: itemWidth, height: itemHeight)
        let xValue = itemWidth / 2 + indexPath.row * (itemWidth + space)
        let yValue = itemHeight + indexPath.section * (itemHeight + space)
        attributes.center = CGPoint(x: xValue, y: yValue)
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var attributes: [UICollectionViewLayoutAttributes] = []
        let minRow: Int = (rect.origin.x > 0.0) ? (Int(rect.origin.x) / Int(itemWidth + space)) : 0
        let maxRow: Int = Int(rect.size.width) / (itemWidth + space) + minRow
        let sectionNum: Int = collectionView?.numberOfSections() ?? 0
        for i in 0...(sectionNum - 1) {
            for j in minRow...maxRow {
                let indexPath = NSIndexPath(forItem: j, inSection: i)
                let attribute = layoutAttributesForItemAtIndexPath(indexPath)
                attributes.append(attribute)
            }
        }
        
        return attributes
    }
   
}
