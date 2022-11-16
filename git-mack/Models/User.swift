//
//  User.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/06.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let htmlUrl: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var company: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
}
