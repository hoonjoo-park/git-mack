//
//  GMFollowerItemVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

class GMFollowerItemVC: GMItemContainerVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(type: .followers, count: user.followers)
        rightItemView.set(type: .following, count: user.following)
        itemButton.set(backgroundColor: GMColors.yellow, title: "깃맥 확인하기", titleColor: .black)
    }
}
