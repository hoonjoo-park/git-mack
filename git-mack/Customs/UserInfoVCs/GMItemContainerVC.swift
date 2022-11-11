//
//  GMItemContainerVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/12.
//

import UIKit

class GMItemContainerVC: UIViewController {
    
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
