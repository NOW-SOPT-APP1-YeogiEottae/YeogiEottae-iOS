//
//  FavoritesListNetworkingManager.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/21.
//

import Foundation

import Moya

final class FavoritesListNetworkingManager {
    static let shared = FavoritesListNetworkingManager()
    private var favoritesListProvider = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}


extension FavoritesListNetworkingManager {
    
    
    
    func getFavoriteList(price: String, review: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        self.favoritesListProvider.request(FavoritesListTargetType.getFavoritesListData) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(byStatusCode: statusCode, data, GetFavoritesListResponseDTO.self)
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
                completion(NetworkResult.networkFail)
                
            }
        }
    }
    
    
    func judgeStatus<T: Codable>(byStatusCode statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        
        switch statusCode {
        case 200..<205:
            let decodedData = self.decodeJSON(dataToDecode: data)
            return NetworkResult.success(decodedData)
            //return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    
    private func decodeJSON(dataToDecode data: Data) -> GetFavoritesListResponseDTO {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(GetFavoritesListResponseDTO.self, from: data)
            
        } catch(let error) {
            fatalError(error.localizedDescription)
        }
    }
    
    
    func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️ \(self)에서 디코딩 오류가 발생했습니다 ⛔️")
            return .decodedErr
        }
        return .success(decodedData as Any)
    }
    
}
