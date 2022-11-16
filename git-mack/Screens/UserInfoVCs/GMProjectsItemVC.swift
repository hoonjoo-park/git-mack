//
//  GMProjectsItemVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

protocol ProjectsItemVCDelegate: AnyObject {
    func onProjectButtonTapped(user: User)
}

class GMProjectsItemVC: GMItemContainerVC {
    
    weak var delegate: ProjectsItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(user: User, delegate: ProjectsItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        leftItemView.set(type: .repos, count: user.publicRepos)
        rightItemView.set(type: .gists, count: user.publicGists)
        itemButton.set(backgroundColor: GMColors.blue, title: "프로필 바로가기", titleColor: .white)
    }
    
    override func onButtonTapped() { delegate.onProjectButtonTapped(user: user) }
}
