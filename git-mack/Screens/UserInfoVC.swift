//
//  FollowerInfoVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/11.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let profileInfoView = UIView()
    let projectsView = UIView()
    let followersView = UIView()
    let dateLabel = GMSecondaryTitleLabel(fontSize: 16, color: .systemGray)
    var infoViews: [UIView] = []
    
    var username: String!
    

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
                DispatchQueue.main.async {
                    self.add(childVC: GMProfileInfoVC(user: user), containerView: self.profileInfoView)
                }
            case .failure(let error):
                self.presentGMAlertOnMainThread(title: "오류", message: error.rawValue)
            }
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = UIColor(r: 15, g: 24, b: 44)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func configureUI() {
        let padding: CGFloat = 20
        let boxHeight: CGFloat = 140
        
        infoViews = [profileInfoView, projectsView, followersView, dateLabel]
        
        dateLabel.text = "날짜가 들어갈 예정"
        dateLabel.textAlignment = .center
        
        for infoView in infoViews {
            infoView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(infoView)
            
            NSLayoutConstraint.activate([
                infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        projectsView.backgroundColor = .green
        followersView.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            profileInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            profileInfoView.heightAnchor.constraint(equalToConstant: 180),
            
            projectsView.topAnchor.constraint(equalTo: profileInfoView.bottomAnchor, constant: padding),
            projectsView.heightAnchor.constraint(equalToConstant: boxHeight),
            
            followersView.topAnchor.constraint(equalTo: projectsView.bottomAnchor, constant: padding),
            followersView.heightAnchor.constraint(equalToConstant: boxHeight),
            
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
