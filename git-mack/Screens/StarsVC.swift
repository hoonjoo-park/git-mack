//
//  FavoritesVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/01.
//

import UIKit

class StarsVC: UIViewController {
    let starTableView = UITableView()
    
    var stars: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStars()
    }
    
    func configureViewController() {
        view.backgroundColor = GMColors.mainNavy
        title = "Stars"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(starTableView)
        
        starTableView.frame = view.bounds
        starTableView.rowHeight = 80
        starTableView.backgroundColor = GMColors.mainNavy
        starTableView.dataSource = self
        starTableView.delegate = self
        
        starTableView.register(StarCell.self, forCellReuseIdentifier: StarCell.reuseID)
        
    }
    
    func fetchStars() {
        PersistenceManager.retrieveStars { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let stars):
                if stars.isEmpty {
                    self.showNotFoundView(message: "아직 즐겨찾기한 유저가 없습니다.", view: self.view)
                } else {
                    self.stars = stars
                    DispatchQueue.main.async {
                        self.starTableView.reloadData()
                        self.starTableView.bringSubviewToFront(self.starTableView)
                    }
                }
            
            case .failure(let error):
                self.presentGMAlertOnMainThread(title: "오류", message: error.rawValue)
            }
        }
    }
}

extension StarsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarCell.reuseID) as! StarCell
        let star = stars[indexPath.row]
        cell.set(user: star)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let star = stars[indexPath.row]
        let destVC = FollowerListVC(username: star.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let star = stars[indexPath.row]
        stars.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateStars(user: star, action: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            
            self.presentGMAlertOnMainThread(title: "오류", message: error.rawValue)
        }
    }
}
