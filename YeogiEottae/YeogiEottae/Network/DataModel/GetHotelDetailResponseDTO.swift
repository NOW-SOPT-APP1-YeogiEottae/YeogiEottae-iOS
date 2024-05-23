//
//  GetHotelDetailResponseDTO.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/22.
//

import Foundation

struct GetHotelDetailResponseDTO: Codable {
    let code: Int
    let success: Bool
    let message: String
    let hotelDetail: HotelDetail
    
    enum CodingKeys: String, CodingKey {
        case code, success, message
        case hotelDetail = "result"
    }
}

struct HotelDetail: Codable {
    let hotelName, star, location: String
    let reviewRate: Double
    let reviewCount: Int
    let isLiked: Bool
    let roomList: [RoomDetail]
}

struct RoomDetail: Codable {
    let roomID: Int
    let roomName: String
    let price: Int
    let startTime, endTime: String
    let imageURL: String
    let isLiked: Bool

    enum CodingKeys: String, CodingKey {
        case roomID = "roomId"
        case roomName, price, startTime, endTime
        case imageURL = "imageUrl"
        case isLiked
    }
}
