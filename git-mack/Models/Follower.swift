//
//  Follower.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import Foundation

struct Follower: Codable, Hashable {
    var uuid = UUID().uuidString

    private enum CodingKeys : String, CodingKey { case login, avatarUrl }
    
    var login: String
    var avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
