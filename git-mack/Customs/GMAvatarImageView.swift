//
//  GMAvatarImageView.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import UIKit

class GMAvatarImageView: UIImageView {
    
    let defaultImage = UIImage(named: "place-holder")!
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = defaultImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 에러핸들링을 해줄 필요가 없기 때문에, 그냥 뷰에서 구현 (에러가 나면 DefaultImage가 적용되며 에러핸들링으로써의 역할을 하기 때문)
    func downloadImage(imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else { return } // 이미지 URL이 넘어오지 않았을 경우 그냥 return
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            let cacheKey = NSString(string: imageUrl)
            
            if let cachedImage = self.cache.object(forKey: cacheKey) {
                DispatchQueue.main.async { self.image = cachedImage }
                return
            }
            
            // 에러가 nil일 때만 코드를 실행
            guard error == nil else { return }
            
            // response가 존재하고, 200코드일 때만 아래의 코드들을 실행
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            // 이미지를 캐싱
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
