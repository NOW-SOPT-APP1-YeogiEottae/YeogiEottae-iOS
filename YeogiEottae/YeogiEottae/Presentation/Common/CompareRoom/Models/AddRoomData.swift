//
//  AddRoomData.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit

struct AddRoomData: Codable {
    let roomId: Int
    let hotelName: String
    let roomName: String
    let location: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case hotelName = "hotel_name"
        case roomName = "room_name"
        case location
        case imageUrl = "image_url"
    }
}

extension AddRoomData {
    static var emptyData = AddRoomData(roomId: 0, hotelName: "", roomName: "", location: "", imageUrl: "advertise")
}

extension AddRoomData {
    static func dummyData() -> [AddRoomData] {
        return [
            AddRoomData(roomId: 1, hotelName: "그랜드 인터컨티넨탈 파르나스", roomName: "클래식 킹", location: "서울 강남구 테헤란로 521", imageUrl: "https://bit.ly/3QLU662"),
            AddRoomData(roomId: 2, hotelName: "서울 신라 호텔", roomName: "디럭스 트윈", location: "서울 중구 동호로 249", imageUrl: "https://bit.ly/3QLU662"),
            AddRoomData(roomId: 3, hotelName: "롯데 호텔 서울", roomName: "프리미어 룸", location: "서울 중구 을지로 30", imageUrl: "https://bit.ly/3QLU662"),
            AddRoomData(roomId: 4, hotelName: "JW 메리어트 호텔 서울", roomName: "이그제큐티브 스위트", location: "서울 서초구 신반포로 176", imageUrl: "https://bit.ly/3QLU662"),
            AddRoomData(roomId: 5, hotelName: "파크 하얏트 서울", roomName: "파크 디럭스 킹", location: "서울 강남구 테헤란로 606", imageUrl: "https://bit.ly/3QLU662")
        ]
    }
}

