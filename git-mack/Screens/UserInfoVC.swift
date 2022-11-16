//
//  FollowerInfoVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/11.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func onProjectButtonTapped(user: User)
    func onFollowerButtonTapped(user: User)
}

class UserInfoVC: UIViewController {
    
    let profileInfoView = UIView()
    let projectsView = UIView()
    let followersView = UIView()
    let dateLabel = GMSecondaryTitleLabel(fontSize: 16, color: .systemGray)
    var infoViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
        fetchUserInfo()
    }
    
    private func fetchUserInfo() {
        NetworkManager.shared.fetchUser(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(user: user) }
            case .failure(let error):
                self.presentGMAlertOnMainThread(title: "오류", message: error.rawValue)
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = GMColors.mainNavy
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureUIElements(user: User) {
        let projectsItemVC = GMProjectsItemVC(user: user)
        let followerItemVC = GMFollowerItemVC(user: user)
        
        projectsItemVC.delegate = self
        followerItemVC.delegate = self
        
        self.add(childVC: GMProfileInfoVC(user: user), containerView: self.profileInfoView)
        self.add(childVC: projectsItemVC, containerView: self.projectsView)
        self.add(childVC: followerItemVC, containerView: self.followersView)
        self.dateLabel.text = "Github 가입: \(user.createdAt.toYearMonthDate())"
    }
    
    private func configureUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 160
        
        infoViews = [profileInfoView, projectsView, followersView, dateLabel]
        
        dateLabel.textAlignment = .center
        
        for infoView in infoViews {
            infoView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(infoView)
            
            NSLayoutConstraint.activate([
                infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            profileInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            profileInfoView.heightAnchor.constraint(equalToConstant: 180),
            
            projectsView.topAnchor.constraint(equalTo: profileInfoView.bottomAnchor, constant: padding),
            projectsView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            followersView.topAnchor.constraint(equalTo: projectsView.bottomAnchor, constant: padding),
            followersView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: followersView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
    
    func add(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoVCDelegate {
    func onProjectButtonTapped(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGMAlertOnMainThread(title: "오류", message: "Github URL에 이상이 있는 것 같습니다. 다시 시도해 주세요.")
            return
        }
        
        presentSafariVC(url: url)
    }
    
    func onFollowerButtonTapped(user: User) {
        delegate.onRequestFollowers(username: user.login)
        
        dismissViewController()
    }    
}
