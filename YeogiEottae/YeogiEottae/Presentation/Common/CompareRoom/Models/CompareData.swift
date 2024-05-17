//
//  TestData.swift
//  Tving-Clone
//
//  Created by Seonwoo Kim on 5/15/24.
//

import UIKit

// MARK: - RoomData
struct RoomData: Codable {
    let roomId: Int
    let hotelName: String
    let roomName: String
    let price: Int
    let reviewRate: Double
    let reviewCount: Int
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case roomId
        case hotelName
        case roomName
        case price
        case reviewRate
        case reviewCount
        case imageUrl
    }
}

extension RoomData {
    static var emptyData = RoomData(roomId: 0, hotelName: "", roomName: "", price: 0, reviewRate: 0.0, reviewCount: 0, imageUrl: "advertise")
}

extension RoomData {
    static func dummyData() -> [RoomData] {
        return [
            RoomData(roomId: 1, hotelName: "그랜드 인터컨티넨탈", roomName: "클래식 킹", price: 464640, reviewRate: 9.4, reviewCount: 2183, imageUrl: "advertise"),
            RoomData(roomId: 3, hotelName: "서울 신라 호텔", roomName: "디럭스 트윈", price: 497000, reviewRate: 9.8, reviewCount: 1183, imageUrl: "advertise"),
            RoomData(roomId: 2, hotelName: "그랜드 인터컨티넨탈", roomName: "주니어 스위트 킹", price: 608679, reviewRate: 9.4, reviewCount: 2183, imageUrl: "advertise"),
            RoomData(roomId: 2, hotelName: "그랜드 인터컨티넨탈", roomName: "주니어 스위트 킹", price: 608679, reviewRate: 9.4, reviewCount: 2183, imageUrl: "advertise"),
            RoomData(roomId: 2, hotelName: "그랜드 인터컨티넨탈", roomName: "주니어 스위트 킹", price: 608679, reviewRate: 9.4, reviewCount: 2183, imageUrl: "advertise"),
            RoomData(roomId: 2, hotelName: "그랜드 인터컨티넨탈", roomName: "주니어 스위트 킹", price: 608679, reviewRate: 9.4, reviewCount: 2183, imageUrl: "advertise")
        ]
    }
}