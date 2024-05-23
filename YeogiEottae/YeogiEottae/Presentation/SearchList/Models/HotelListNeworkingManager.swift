//
//  HotelListNetworkingManager.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/23.
//

import Foundation

/*
 더미데이터 입니다!
 사전에 제공된 JSON 데이터를 이용하여 GetHoteListResponseDTO 타입 인스턴스를 반환하는 함수를 가짐.
 더미데이터이므로, Network 폴더에 넣지 않고, SearchList 폴더의 Models에 구성하였습니다.
 */


public let jsonString: String = """
{
  "code": 200,
  "success": true,
  "result": {
    "hotel_list": [
      {
          "hotel_id": 1,
        "hotel_name": "그랜드 인터컨티넨탈 파르나스",
        "location": "삼성역 도보 5분",
        "type": "호텔",
        "review_rate": 9.4,
        "review_count": 2183,
        "price": 464640,
        "image_url": "https://bit.ly/4bF6NHO",
        "is_liked": false
      },
      {
        "hotel_id": 2,
        "hotel_name": "서울 신라 호텔",
        "location": "영등포역 도보 3분",
        "type": "호텔",
        "review_rate": 9.8,
        "review_count": 1183,
        "price": 497000,
        "image_url": "https://bit.ly/3VbEMCl",
        "is_liked": false
      },
      {
        "hotel_id": 3,
        "hotel_name": "노보텔 앰버서더 용산",
        "location": "신용산역 도보 3분",
        "type": "호텔",
        "review_rate": 9.4,
        "review_count": 2183,
        "price": 287000,
        "image_url": "https://bit.ly/3wB5DxY",
        "is_liked": false
      },
      {
        "hotel_id": 4,
        "hotel_name": "나인트리 프리미어 로카우스 호텔 서울 용산",
        "location": "건대입구역 도보 3분",
        "type": "호텔",
        "review_rate": 9.4,
        "review_count": 3183,
        "price": 159000,
        "image_url": "https://bit.ly/4dKfFxp",
        "is_liked": false
      },
      {
        "hotel_id": 5,
        "hotel_name": "앰버서더 서울 풀만 호텔",
        "location": "성수역 도보 3분",
        "type": "호텔",
        "review_rate": 9.2,
        "review_count": 2003,
        "price": 586850,
        "image_url": "https://bit.ly/3K43Lkm",
        "is_liked": false
      }
    ]
  }
}
"""

final class HotelListNetworkingManager {
    static let shared = HotelListNetworkingManager()
    private init() {}
    
    
    
    let jsonData = Data(jsonString.utf8)
}

extension HotelListNetworkingManager {
    
    func requestHoteList() -> GetHotelListResponseDTO {
        
        let decoder = JSONDecoder()
        do {
            let hotelListDTO = try decoder.decode(GetHotelListResponseDTO.self, from: jsonData)
            return hotelListDTO
        } catch {
            fatalError()
        }
    }
    
}
