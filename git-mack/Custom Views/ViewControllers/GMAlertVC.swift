//
//  AlertVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import UIKit

class GMAlertVC: UIViewController {
    let padding:CGFloat = 20
    
    let alertModal:UIView = GMAlertContainerView()
    let titleLabel:UILabel = GMTitleLabel(fontSize: 18, textAlign: .center, color: .white)
    let bodyLabel:UILabel = GMBodyLabel(textAlign: .center)
    let confirmButton:UIButton = GMButton(backgroundColor: GMColors.blue, title: "Approve!", titleColor: .white)
    
    var alertTitle: String?
    var message: String?
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle = title
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        
        addSubviews()
        configureUI()
    }
    
    func addSubviews() {
        view.addSubviews(alertModal, titleLabel, confirmButton, bodyLabel)
    }
    
    func configureUI() {
        configureAlertModal()
        configureAlertTitle()
        configureConfirmButton()
        configureAlertBody()
    }
    
    func configureAlertModal() {
        NSLayoutConstraint.activate([
            alertModal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertModal.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func configureAlertTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = alertTitle ?? "알 수 없는 오류가 발생했습니다"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertModal.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: alertModal.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: alertModal.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configureConfirmButton() {
        confirmButton.addTarget(self, action: #selector(dismissGMAlertVC), for: .touchUpInside)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: alertModal.bottomAnchor, constant: -padding),
            confirmButton.leadingAnchor.constraint(equalTo: alertModal.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: alertModal.trailingAnchor, constant: -padding),
            confirmButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configureAlertBody() {
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.text = message ?? "잠시 후 다시 시도해 주시기 바랍니다."
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -10),
            bodyLabel.leadingAnchor.constraint(equalTo: alertModal.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: alertModal.trailingAnchor, constant: -padding),
        ])
    }
    
    @objc func dismissGMAlertVC() {
        dismiss(animated: true)
    }
}
