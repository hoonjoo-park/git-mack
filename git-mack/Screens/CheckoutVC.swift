//
//  SearchVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/01.
//

import UIKit

class CheckoutVC: UIViewController {
    let stackView = UIStackView()
    let logoImageView: UIImageView = UIImageView()
    let checkoutButton: UIButton = GMButton(backgroundColor: UIColor(r: 255, g: 213, b: 0), title: "Checkout!", titleColor: .black)
    let usernameTextField: UITextField = GMTextField(placeholder: "깃헙 아이디를 입력하세요")
    let textFieldBorder: UIView = UIView(frame: .zero)
    let screenTitle: UILabel = UILabel()
    
    var isUsernameEmpty: Bool { return usernameTextField.text!.isEmpty }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = GMColors.mainNavy
        configureStackView()
        configureUIElements()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @objc func pushToFollowerListVC() {
        guard !isUsernameEmpty else {
            presentGMAlert(title: "잠깐!", message: "검색하고자 하는 상대방의 깃헙 아이디를 입력해 주세요 🥹")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func configureUIElements() {
        configureLogoImage()
        configureScreenTitle()
        configureTextField()
        configureTextFieldBorder()
        configureCheckoutButton()
        createTabToDismissKeyboardGesture()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(screenTitle)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(textFieldBorder)
        stackView.addArrangedSubview(checkoutButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }
    
    
    func createTabToDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImage() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = GMImages.logo
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 70),
            logoImageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    
    func configureScreenTitle() {
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.text = "다른 개발자들의\n\"깃맥\"을 찾아보세요"
        screenTitle.numberOfLines = 2
        screenTitle.textColor = .white
        screenTitle.font = UIFont.systemFont(ofSize: 28, weight: .black)
        
        NSLayoutConstraint.activate([
            screenTitle.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            screenTitle.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
        ])
        
        highlightSpecificWord(word: "\"깃맥\"")
    }
    
    
    func highlightSpecificWord(word: String) {
        let fullText = screenTitle.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: word)
        attribtuedString.addAttribute(.foregroundColor, value: UIColor(r: 255, g: 213, b: 0), range: range)
        screenTitle.attributedText = attribtuedString
    }
    
    
    func configureTextField() {
        usernameTextField.delegate = self
        usernameTextField.backgroundColor = .none
        usernameTextField.layer.cornerRadius = 0
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 30),
            usernameTextField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            usernameTextField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        usernameTextField.addLeftPadding(width: 10)
        usernameTextField.addRightPadding(width: 10)
    }
    
    
    func configureTextFieldBorder() {
        textFieldBorder.backgroundColor = .white
        textFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldBorder.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 1),
            textFieldBorder.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            textFieldBorder.rightAnchor.constraint(equalTo: usernameTextField.rightAnchor),
            textFieldBorder.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    
    func configureCheckoutButton() {
        checkoutButton.addTarget(self, action: #selector(pushToFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            checkoutButton.topAnchor.constraint(equalTo: textFieldBorder.bottomAnchor, constant: 30),
            checkoutButton.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
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
