//
//  HotelDetailService.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/22.
//

import Foundation

import Moya

final class HotelDetailService {
    static let shared = HotelDetailService()
    private var compareProvider = MoyaProvider<HotelDetailTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension HotelDetailService {
    func getHotelDetailData(hotelID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        compareProvider.request(.getHotelDetailData(hotelID: hotelID)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, GetHotelDetailResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
            return .decodedErr
        }
        return .success(decodedData as Any)
    }
}
