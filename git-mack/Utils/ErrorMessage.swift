//
//  ErrorMessage.swift
//  git-mack
//
//  Created by Hoonjoo Park on 2022/11/07.
//

import Foundation

enum GMErrorMessage: String, Error {
    case invalidUsername    = "깃헙 아이디를 확인해주세요."
    case unableToComplete   = "알 수 없는 오류가 발생했습니다. 인터넷 연결을 확인해 주세요."
    case invalidResponse    = "서버 오류입니다. 잠시 후 다시 시도해 주세요."
    case invalidData        = "서버로부터 올바르지 못한 데이터가 전달되었습니다. 다시 시도해 주세요."
    case invalidFavorites   = "즐겨찾기 리스트를 불러올 수 없습니다. 다시 시도해 주세요."
    case unableToAddFavorite = "즐겨찾기에 해당 유저를 추가할 수 없습니다. 다시 시도해 주세요."
    case favoriteAlreadyExists = "해당 유저는 이미 즐겨찾기에 추가되어 있습니다."
}
