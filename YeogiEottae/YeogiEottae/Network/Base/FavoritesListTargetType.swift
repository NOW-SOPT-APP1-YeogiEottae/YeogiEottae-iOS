//
//  FavoritesListTargetType.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/21.
//

import Foundation

import Moya

enum FavoritesListTargetType {
    case getFavoritesListData
    case removeFromFavorites(isRoom: Bool)
}

extension FavoritesListTargetType: TargetType {
    
    
    var baseURL: URL {
        /*
         BaseURL은 CompareTargetType 파일에서 정의됨.
         */
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getFavoritesListData:
            return "/api/v1/likes"
        case .removeFromFavorites:
            return "/api/v1/likes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFavoritesListData:
            return .get
        case .removeFromFavorites:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getFavoritesListData:
            return .requestPlain
        case .removeFromFavorites(isRoom: let isRoom):
            return .requestParameters(parameters: ["roomType": (isRoom ? "1" : "0")], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getFavoritesListData:
            return ["Content-Type": "application/json",
                    "userId": "1"]
        case .removeFromFavorites:
            return ["Content-Type": "application/json",
                    "userId": "1"]
        }
    }
}
