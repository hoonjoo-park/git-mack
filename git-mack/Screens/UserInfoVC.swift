//
//  FollowerInfoVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/11.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func onRequestFollowers(username: String)
}

class UserInfoVC: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let profileInfoView = UIView()
    let projectsView = UIView()
    let followersView = UIView()
    let dateLabel = GMSecondaryTitleLabel(fontSize: 16, color: .systemGray)
    var infoViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        configureUI()
        fetchUserInfo()
    }
    
    
    private func fetchUserInfo() {
        Task {
            do {
                let user = try await NetworkManager.shared.fetchUser(for: username)
                configureUIElements(user: user)
            } catch {
                if let error = error as? GMErrorMessage {
                    presentGMAlert(title: "오류", message: error.rawValue)
                } else {
                    presentGMAlert(title: "오류", message: "알 수 없는 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.")
                }
            }
        }
    }
    
    
    private func configureViewController() {
        view.backgroundColor = GMColors.mainNavy
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600),
        ])
    }
    
    
    private func configureUIElements(user: User) {    
        self.add(childVC: GMProfileInfoVC(user: user), containerView: self.profileInfoView)
        self.add(childVC: GMProjectsItemVC(user: user, delegate: self), containerView: self.projectsView)
        self.add(childVC: GMFollowerItemVC(user: user, delegate: self), containerView: self.followersView)
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
            dateLabel.heightAnchor.constraint(equalToConstant: 36),
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


extension UserInfoVC: ProjectsItemVCDelegate {
    func onProjectButtonTapped(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGMAlert(title: "오류", message: "Github URL에 이상이 있는 것 같습니다. 다시 시도해 주세요.")
            return
        }

        presentSafariVC(url: url)
    }
}

extension UserInfoVC: FollowerItemVCDelegate {
    func onFollowerButtonTapped(user: User) {
        delegate.onRequestFollowers(username: user.login)

        dismissViewController()
    }
}
