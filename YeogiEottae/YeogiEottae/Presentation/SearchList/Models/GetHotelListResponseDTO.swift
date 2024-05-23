//
//  GetHotelListResponseDTO.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/23.
//

import Foundation

/*
 더미데이터 입니다!
 사전에 제공된 JSON 데이터를 이용하여 swift 형식으로 변환한 GetHoteListResponseDTO 입니다. 
 더미데이터이므로, Network 폴더에 넣지 않고, SearchList 폴더의 Models에 구성하였습니다.
 */

struct GetHotelListResponseDTO: Codable {
    let code: Int
    let success: Bool
    let HotelListResult: HotelListResult
    
    enum CodingKeys: String, CodingKey {
        case code, success
        case HotelListResult = "result"
    }
}


struct HotelListResult: Codable {
    let hotelsArray: [HotelInfo]
    
    enum CodingKeys: String, CodingKey {
        case hotelsArray = "hotel_list"
    }
}


struct HotelInfo: Codable {
    let hotelID: Int
    let hotelName, location, type: String
    let reviewRate: Double
    let reviewCount, price: Int
    let imageURL: String
    let isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotel_id"
        case hotelName = "hotel_name"
        case location, type
        case reviewRate = "review_rate"
        case reviewCount = "review_count"
        case price
        case imageURL = "image_url"
        case isLiked = "is_liked"
    }
}

