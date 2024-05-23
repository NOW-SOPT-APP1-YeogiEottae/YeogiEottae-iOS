//
//  SearchResultViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var hotelsInfoArray: [HotelInfo] = []
    
    let rootView: SearchResultView = SearchResultView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        let hotelListDTO = HotelListNetworkingManager.shared.requestHoteList()
        let hotelListResult = hotelListDTO.HotelListResult
        self.hotelsInfoArray = hotelListResult.hotelsArray
        
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
        //self.rootView.setDelegates(to: self)
    }
    
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotelsInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { fatalError() }
        
        //searchResultCell.configureData(with: self.hotelList[indexPath.item])
        searchResultCell.configureData(with: self.hotelsInfoArray[indexPath.item])
        return searchResultCell
    }
    
}
