//
//  GetLikeCompareResponseDTO.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/22/24.
//

import Foundation

struct GetLikeCompareResponseDTO: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: [RoomList]
}

struct RoomList: Codable {
    let roomId: Int
    let hotelName: String
    let roomName: String
    let location: String
    let imageUrl: String
}


