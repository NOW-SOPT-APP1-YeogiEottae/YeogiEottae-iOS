//
//  SearchResultViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    
    let hotelList: [Hotel] = [
        
        Hotel(name: "그랜드 인터컨티넨탈 파르나스", rate: 9.4, starRating: 5, price: 90000),
        Hotel(name: "서울 신라 호첼", rate: 9.8, starRating: 5, price: 90000),
        Hotel(name: "글래드 여의도", rate: 9.4, starRating: 4, price: 90000),
        Hotel(name: "나인트리 프리미어 로카우스 호텔 서울 용산", rate: 9.4, starRating: 5, price: 90000),
        Hotel(name: "앰배서더 서울 풀만 호텔", rate: 9.2, starRating: 5, price: 90000),
        
    ]
    
    
    let rootView: SearchResultView = SearchResultView()
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rootView.setTableViewDataSourceDelegate(to: self)
    }
    
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotelList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let searchResultHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchResultHeaderView.reuseIdentifier) as? SearchResultHeaderView else { fatalError() }
        
        return searchResultHeaderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as? SearchResultCell else { fatalError() }
        
        searchResultCell.configureData(with: self.hotelList[indexPath.item])
        return searchResultCell
    }
}


extension SearchResultViewController: UITableViewDelegate {
    
}
