//
//  NetworkManager.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/"
    
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func fetchFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GMErrorMessage>) -> Void) {
        let endPoint = baseUrl + "users/\(username)/followers?per_page=50&page=\(page)"

        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
    
    func fetchUser(for username: String, completion: @escaping (Result<User, GMErrorMessage>) -> Void) {
        let endPoint = baseUrl + "users/\(username)"
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                
                let userInfo = try decoder.decode(User.self, from: data)
                completion(.success(userInfo))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: imageUrl)
        
        if let cachedImage = cache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            
            // 이미지를 캐싱
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
}
