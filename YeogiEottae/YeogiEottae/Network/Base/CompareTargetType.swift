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
    case getLikeCompareData
    case postLikeCompareDatarequest(request: PostLikeCompareRequestDTO)
    case deleteLikeCompareData(request: DeleteLikeRoomRequestDTO)
}

extension CompareTargetType: TargetType {
    
    
    var baseURL: URL {
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getCompareListData:
            return "api/v1/compare-rooms"
        case .getLikeCompareData, .postLikeCompareDatarequest, .deleteLikeCompareData:
            return "api/v1/compare-rooms/likes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCompareListData, .getLikeCompareData:
            return .get
        case .postLikeCompareDatarequest:
            return .post
        case .deleteLikeCompareData:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getCompareListData(price: let price, review: let review):
            return .requestParameters(
                parameters: [
                    "price": "0",
                    "review": "0"
                ],
                encoding: URLEncoding.default
            )
        case .getLikeCompareData:
            return .requestPlain
        case .postLikeCompareDatarequest(request: let request):
            return .requestJSONEncodable(request)
        case .deleteLikeCompareData(request: let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "userId": "1"]
    }
}
