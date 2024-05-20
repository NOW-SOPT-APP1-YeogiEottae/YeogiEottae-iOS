//
//  CompareListResponseDTO.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import Foundation

struct CompareListResponseDTO: Codable {
    let code: Int
    let success: Bool
    let message: String
    let result: [RoomDTO]
}

struct RoomDTO: Codable {
    let roomId: Int
    let hotelName: String
    let roomName: String
    let price: Int
    let reviewRate: Double
    let reviewCount: Int
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "roomID"
        case hotelName
        case roomName
        case price
        case reviewRate
        case reviewCount
        case imageUrl = "imageURL"
    }
}

