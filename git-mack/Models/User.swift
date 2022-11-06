//
//  User.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import Foundation

struct User: Codable {
    var login: String
    var htmlUrl: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var company: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var createdAt: String
}
