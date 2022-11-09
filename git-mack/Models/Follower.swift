//
//  Follower.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import Foundation

struct Follower: Codable, Hashable {
    let id: Int
    var login: String
    var avatarUrl: String
}
