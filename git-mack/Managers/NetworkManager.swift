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
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func fetchFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endPoint = baseUrl + "users/\(username)/followers?per_page=50&page=\(page)"
        guard let url = URL(string: endPoint) else { throw GMErrorMessage.invalidUsername }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GMErrorMessage.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GMErrorMessage.invalidData
        }
    }
    
    
    func fetchUser(for username: String) async throws -> User {
        let endPoint = baseUrl + "users/\(username)"
        guard let url = URL(string: endPoint) else { throw GMErrorMessage.invalidUsername }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GMErrorMessage.invalidResponse }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GMErrorMessage.invalidData
        }
    }
    
    func downloadImage(imageUrl: String) async -> UIImage? {
        let cacheKey = NSString(string: imageUrl)
        if let cachedImage = cache.object(forKey: cacheKey) { return cachedImage }
        
        guard let url = URL(string: imageUrl) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
