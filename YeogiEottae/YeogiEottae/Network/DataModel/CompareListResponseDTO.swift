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
    let result: [CompareList]
}

struct CompareList: Codable {
    let roomId: Int
    let hotelName: String
    let roomName: String
    let price: Int
    let reviewRate: Double
    let reviewCount: Int
    let imageUrl: String
}

