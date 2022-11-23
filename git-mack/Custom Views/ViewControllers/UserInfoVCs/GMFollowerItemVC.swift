//
//  GMFollowerItemVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

protocol FollowerItemVCDelegate: AnyObject {
    func onFollowerButtonTapped(user: User)
}

class GMFollowerItemVC: GMItemContainerVC {
    
    weak var delegate: FollowerItemVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(user: User, delegate: FollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        leftItemView.set(type: .followers, count: user.followers)
        rightItemView.set(type: .following, count: user.following)
        itemButton.set(backgroundColor: GMColors.yellow, title: "깃맥 확인하기", titleColor: .black)
    }
    
    override func onButtonTapped() {
        delegate.onFollowerButtonTapped(user: user)
    }
}
