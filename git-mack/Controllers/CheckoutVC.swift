//
//  SearchVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/01.
//

import UIKit

class CheckoutVC: UIViewController {
    let logoImageView: UIImageView = UIImageView()
    let checkoutButton: UIButton = GMButton(backgroundColor: UIColor(r: 255, g: 213, b: 0), title: "Checkout!", titleColor: .black)
    let usernameTextField: UITextField = GMTextField(placeholder: "깃헙 아이디를 입력하세요")
    let textFieldBorder: UIView = UIView(frame: .zero)
    let screenTitle: UILabel = UILabel()
    
    var isUsernameEmpty: Bool { return usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 15, g: 24, b: 44)
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func pushToFollowerListVC() {
        guard !isUsernameEmpty else {
            presentGMAlertOnMainThread(title: "잠깐!", message: "검색하고자 하는 상대방의 깃헙 아이디를 입력해 주세요 🥹")
            return
        }
        
        let followerListVC = FollowerListVC()
        
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureUI() {
        configureLogoImage()
        configureScreenTitle()
        configureTextField()
        configureTextFieldBorder()
        configureCheckoutButton()
        createTabToDismissKeyboardGesture()
    }
    
    func createTabToDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImage() {
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gitmack-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    func configureScreenTitle() {
        view.addSubview(screenTitle)
        
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.text = "다른 개발자들의\n\"깃맥\"을 찾아보세요"
        screenTitle.numberOfLines = 2
        screenTitle.textColor = .white
        screenTitle.font = UIFont.systemFont(ofSize: 28, weight: .black)
        
        NSLayoutConstraint.activate([
            screenTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            screenTitle.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 100),
        ])
        
        let fullText = screenTitle.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "\"깃맥\"")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor(r: 255, g: 213, b: 0), range: range)
        screenTitle.attributedText = attribtuedString
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        usernameTextField.backgroundColor = .none
        usernameTextField.layer.cornerRadius = 0
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 60),
            usernameTextField.leftAnchor.constraint(equalTo: screenTitle.leftAnchor),
            usernameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        usernameTextField.addLeftPadding(width: 10)
    }
    
    func configureTextFieldBorder() {
        view.addSubview(textFieldBorder)
        
        textFieldBorder.backgroundColor = .white
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldBorder.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 1),
            textFieldBorder.leftAnchor.constraint(equalTo: usernameTextField.leftAnchor),
            textFieldBorder.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            textFieldBorder.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func configureCheckoutButton() {
        view.addSubview(checkoutButton)
        
        checkoutButton.addTarget(self, action: #selector(pushToFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            checkoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkoutButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 40),
            checkoutButton.leftAnchor.constraint(equalTo: usernameTextField.leftAnchor),
            checkoutButton.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            checkoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension CheckoutVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowerListVC()
        return true
    }
}
