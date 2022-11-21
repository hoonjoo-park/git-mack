//
//  FollowerListVC.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/05.
//

import UIKit

class FollowerListVC: GMDataLoadingVC {
    
    enum Section { case main }
    
    var username: String!
    var page = 1
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var hasMoreData = true
    var isSearching = false
    var isFetching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
        self.title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDefault()
        configureCollectionView()
        fetchFollowers(username: username, page: page)
        configureDataSource()
        configureSearchBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func fetchFollowers(username: String, page: Int) {
        showLoadingView()
        isFetching = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.fetchFollowers(for: username, page: page)
                appendFollowers(followers: followers)
            } catch {
                if let error = error as? GMErrorMessage {
                    self.presentGMAlert(title: "오류", message: error.rawValue)
                } else {
                    self.presentDefaultError()
                }
            }
        }
        
        hideLoadingView()
        isFetching = false
    }
    
    
    func appendFollowers(followers: [Follower]) {
        if followers.count < 50 { self.hasMoreData = false }
        
        self.followers.append(contentsOf: followers)
        self.updateData(followers: self.followers)
        
        if followers.isEmpty {
            let message = "해당 사용자를 아무도 팔로우 하고 있지 않습니다 🤔"
            DispatchQueue.main.async { self.showNotFoundView(message: message, view: self.view) }
        }
    }
    
    
    func updateData(followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    func configureDefault() {
        view.backgroundColor = GMColors.mainNavy
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStar))
        
        navigationItem.rightBarButtonItem = rightButton
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc func addStar() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.fetchUser(for: username)
                addUserToStars(user: user)
            } catch {
                if let error = error as? GMErrorMessage {
                    presentGMAlert(title: "오류", message: error.rawValue)
                } else {
                    presentDefaultError()
                }
            }
        }
        
        hideLoadingView()
    }
    
    
    func addUserToStars(user: User) {
        let favorite = Follower(id: user.id, login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateStars(user: favorite, action: .add) { [weak self] error in
            guard let self else { return }
            
            guard let error else {
                self.presentGMAlert(title: "성공", message: "상대방을 나의 즐겨찾기에 추가했습니다 🥳")
                return
            }
            
            self.presentGMAlert(title: "오류 ", message: error.rawValue)
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(view: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = GMColors.subNavy
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.setCell(follower: follower)
            
            return cell
        })
    }
    
    
    func configureSearchBar() {
        let searchController = UISearchController()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "유저 아이디를 입력해 필터링해보세요"
        
        navigationItem.searchController = searchController
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let scrollHeight = scrollView.contentSize.height
        let containerHeight = scrollView.frame.size.height
        
        if offsetY + containerHeight + 50 >= scrollHeight {
            guard hasMoreData, !isFetching, filteredFollowers.isEmpty else { return }
            
            page += 1
            fetchFollowers(username: username, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follwersArray = isSearching ? filteredFollowers : followers
        let follower = follwersArray[indexPath.item]
        
        let userInfoVC = UserInfoVC()
        userInfoVC.username = follower.login
        userInfoVC.delegate = self
        
        let navigationController = UINavigationController(rootViewController: userInfoVC)
        present(navigationController, animated: true)
        
    }
}

extension FollowerListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            updateData(followers: followers)
            filteredFollowers.removeAll()
            
            return
        }
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(text.lowercased()) }
        updateData(followers: filteredFollowers)
    }
}

extension FollowerListVC: UserInfoVCDelegate {
    func onRequestFollowers(username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        fetchFollowers(username: username, page: page)
    }
}
