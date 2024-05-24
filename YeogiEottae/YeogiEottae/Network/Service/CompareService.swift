//
//  CompareService.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import Foundation

import Moya

final class CompareService {
    static let shared = CompareService()
    private var compareProvider = MoyaProvider<CompareTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension CompareService {
    func getComparerListData(price: String, review: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        compareProvider.request(.getCompareListData(price: price, review: review)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, CompareListResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func getLikeCompareData(completion: @escaping (NetworkResult<Any>) -> Void) {
        compareProvider.request(.getLikeCompareData) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, GetLikeCompareResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func postLikeCompareData(request: PostLikeCompareRequestDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        compareProvider.request(.postLikeCompareDatarequest(request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, PostLikeCompareResponseDTO.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func deleteLikeCompareData (request: DeleteLikeRoomRequestDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        compareProvider.request(.deleteLikeCompareData(request: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, DeleteLikeRoomResponseDTO.self)
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
            return .pathErr
        }
        return .success(decodedData as Any)
    }
}



