//
//  FollowerListVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/05.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section { case main }
    
    var username: String!
    var page = 1
    var followers: [Follower] = []
    var hasMoreData = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefault()
        configureCollectionView()
        fetchFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureDefault() {
        view.backgroundColor = UIColor(r: 15, g: 24, b: 44)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(r: 15, g: 24, b: 44)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func fetchFollowers(username: String, page: Int) {
        showLoadingView()
        
        NetworkManager.shared.fetchFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.hideLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 50 { self.hasMoreData = false }
                
                self.followers.append(contentsOf: followers)
                self.updateData()
                
                if followers.isEmpty {
                    let message = "해당 사용자를 아무도 팔로우 하고 있지 않습니다 🤔"
                    DispatchQueue.main.async {
                        self.showNotFoundView(message: message, view: self.view)
                    }
                }
                
            case .failure(let error):
                self.presentGMAlertOnMainThread(title: "오류", message: error.rawValue)
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.setCell(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let scrollHeight = scrollView.contentSize.height
        let containerHeight = scrollView.frame.size.height
        
        if offsetY + containerHeight + 50 >= scrollHeight {
            guard hasMoreData else { return }
            
            page += 1
            fetchFollowers(username: username, page: page)
        }
    }
}
