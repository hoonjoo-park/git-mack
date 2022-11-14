//
//  PersistenceManager.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/14.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let stars = "Stars"
    }
    
    static func updateStars(user: Follower, action: PersistenceActionType, completion: @escaping (GMErrorMessage?) -> Void ) {
        retrieveStars { result in
            switch result {
            case .success(let stars):
                var retrievedStars = stars
                
                switch action {
                case .add:
                    guard !retrievedStars.contains(user) else {
                        completion(.starAlreadyExists)
                        return
                    }
                    
                    retrievedStars.append(user)

                case .remove:
                    retrievedStars.removeAll { $0.login == user.login }
                }
                
                completion(addStars(stars: retrievedStars))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveStars(completion: @escaping (Result<[Follower], GMErrorMessage>) -> Void) {
        guard let starsData = defaults.object(forKey: Keys.stars) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedStars = try decoder.decode([Follower].self, from: starsData)
            completion(.success(decodedStars))
        } catch {
            completion(.failure(.invalidStars))
        }
    }
    
    static func addStars(stars: [Follower]) -> GMErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedStars = try encoder.encode(stars)
            defaults.set(encodedStars, forKey: Keys.stars)
            return nil
        } catch {
            return .unableToAddStar
        }
    }
}
