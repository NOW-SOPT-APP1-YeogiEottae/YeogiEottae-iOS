//
//  FavoritesListResponseDTO.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/21.
//

import Foundation

//MARK: - FavoritesListResponseDTO(민성)
struct GetFavoritesListResponseDTO: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: [FavoriteContentDTO]
}

struct FavoriteContentDTO: Codable {
    let hotelID: Int
    let hotelName: String
    let reviewRate: Double
    let roomInformation: RoomInformation? //호텔만 찜했을 경우에는 이 값이 null임.

    enum CodingKeys: String, CodingKey {
        case hotelID = "hotelId"
        case hotelName, reviewRate, roomInformation
    }
}

struct RoomInformation: Codable {
    let roomID: Int
    let roomName, roomImageURL: String
    let price: Int //쿠폰적용시 가격(쿠폰 미적용시 가격은 하드코딩)

    enum CodingKeys: String, CodingKey {
        case roomID = "roomId"
        case roomName
        case roomImageURL = "roomImage"
        case price
    }
}
