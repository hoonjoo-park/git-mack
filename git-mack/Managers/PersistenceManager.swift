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
        static let favorites = "Favorites"
    }
    
    static func updateFavorites(userToAdd: Follower, action: PersistenceActionType, completion: @escaping (GMErrorMessage?) -> Void ) {
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch action {
                case .add:
                    guard !retrievedFavorites.contains(userToAdd) else {
                        completion(.favoriteAlreadyExists)
                        return
                    }
                    
                    retrievedFavorites.append(userToAdd)

                case .remove:
                    retrievedFavorites.removeAll { $0.login == userToAdd.login }
                }
                
                completion(addFavorites(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GMErrorMessage>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(decodedFavorites))
        } catch {
            completion(.failure(.invalidFavorites))
        }
    }
    
    static func addFavorites(favorites: [Follower]) -> GMErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToAddFavorite
        }
    }
}
