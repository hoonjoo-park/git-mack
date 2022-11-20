//
//  GMItemContainerVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

protocol ItemContainerVCDelegate: AnyObject {
    func onProjectButtonTapped(user: User)
    func onFollowerButtonTapped(user: User)
}

class GMItemContainerVC: UIViewController {
    
    var user: User!
    
    let stackView = UIStackView()
    let leftItemView = GMInfoCountView()
    let rightItemView = GMInfoCountView()
    let itemButton = GMButton()
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllor()
        configureStackView()
        configureButtonAction()
        configureUI()
        
    }
    
    private func configureViewControllor() {
        view.backgroundColor = GMColors.subNavy
        view.layer.cornerRadius = 18
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(leftItemView)
        stackView.addArrangedSubview(rightItemView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureButtonAction() {
        itemButton.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    }
    
    private func configureUI() {
        view.addSubviews(stackView, itemButton)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            itemButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            itemButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc func onButtonTapped() {}
}
