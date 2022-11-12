//
//  UIHelper.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/09.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemSpacing: CGFloat = 10
        let containerWidth = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth = containerWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}


enum GMColors {
    static let blue = UIColor(r: 1, g: 93, b: 228)
    static let yellow = UIColor(r: 255, g: 213, b: 0)
    static let mainNavy = UIColor(r: 15, g: 24, b: 44)
    static let subNavy = UIColor(r: 27, g: 37, b: 56)
}
