//
//  GMProjectsItemVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

class GMProjectsItemVC: GMItemContainerVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        leftItemView.set(type: .repos, count: user.publicRepos)
        rightItemView.set(type: .gists, count: user.publicGists)
        itemButton.set(backgroundColor: GMColors.blue, title: "프로필 바로가기", titleColor: .white)
    }
    
    override func onButtonTapped() { delegate.onProjectButtonTapped(user: user) }
}
