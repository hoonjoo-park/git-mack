//
//  GMTextField.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/04.
//

import UIKit

class GMTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 8
        
        backgroundColor = .white
        textColor = .white
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        clearButtonMode = .whileEditing
        returnKeyType = .go
        autocapitalizationType = .none
        
        autocorrectionType = .no
        
    }
    
}
