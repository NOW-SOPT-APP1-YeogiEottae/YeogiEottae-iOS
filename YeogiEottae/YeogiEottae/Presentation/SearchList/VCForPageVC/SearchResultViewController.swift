//
//  SearchResultViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

import Moya

class SearchResultViewController: UIViewController {
    
    let provider = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    
    var hotelsInfoArray: [HotelInfo] = []
    var favoritesAccommodationsArray: [FavoriteContentDTO] = [] {
        didSet {
            //Moya를 사용하기 때문에, DispatchQueue.main.async { } 코드는 필수 아님
            DispatchQueue.main.async { self.rootView.tableView.reloadData() }
        }
    }
    var favoritesAccommodationIDArray: [Int] {
        self.favoritesAccommodationsArray.map { favoriteContent in
            return favoriteContent.hotelID
        }
    }
    
    let rootView: SearchResultView = SearchResultView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        let hotelListDTO = HotelListNetworkingManager.shared.requestHoteList() //더미데이터입니다.
        let hotelListResult = hotelListDTO.HotelListResult
        self.hotelsInfoArray = hotelListResult.hotelsArray
        
        self.getFavoriteContent { decodedData in
            self.favoritesAccommodationsArray = decodedData.result
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView.setTableViewDataSourceDelegate(to: self)
    }
    
    func getFavoriteContent(completion: @escaping (_ decodedData: GetFavoritesListResponseDTO) -> Void) {
        self.provider.request(.getFavoritesListData) { result in
            switch result {
            case .success(let response):
                let data = response.data
                guard let decodedData = try? JSONDecoder().decode(GetFavoritesListResponseDTO.self, from: data) else { return }
                completion(decodedData)
                
            case .failure(let moyaError):
                fatalError(moyaError.localizedDescription)
            }
        }
    }
    
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotelsInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { fatalError() }
        let hotelInfo = self.hotelsInfoArray[indexPath.row]
        searchResultCell.configureData(with: hotelInfo)
        
        if self.favoritesAccommodationIDArray.contains(hotelInfo.hotelID) {
            searchResultCell.heartButton.isSelected = true
        }
        return searchResultCell
    }
    
}
