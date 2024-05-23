//
//  HotelDetailTargetType.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/22.
//

import Foundation

import Moya

enum HotelDetailTargetType {
    case getHotelDetailData(hotelID: Int)
}

extension HotelDetailTargetType: TargetType {
    
    
    var baseURL: URL {
        /*
         BaseURL은 CompareTargetType 파일에서 정의됨.
         */
        return URL(string: BaseURL)!
    }
    
    var path: String {
        switch self {
        case .getHotelDetailData(let hotelID):
            return "/api/v1/hotels/\(hotelID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHotelDetailData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHotelDetailData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getHotelDetailData:
            return ["Content-Type": "application/json",
                    "userId": "1"]
        }
    }
}
