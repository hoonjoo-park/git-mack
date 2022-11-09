//
//  NetworkManager.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/"
    
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
}
