//
//  CompareTargetType.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import Foundation

import Moya

let BaseURL = Bundle.main.infoDictionary?["BASE_URL"] as! String

enum CompareTargetType {
    case getCompareListData(price: String, review: String)
}

extension CompareTargetType: TargetType {
    
    
    var baseURL: URL {
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getCompareListData:
            return "api/v1/compare-rooms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCompareListData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCompareListData(price: let price, review: let review):
            return .requestParameters(parameters: ["price": "0",
                                                   "review": "0"], encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getCompareListData(price: let price, review: let review):
            return ["Content-Type": "application/json",
                    "userId": "1"]
        }
    }
}
