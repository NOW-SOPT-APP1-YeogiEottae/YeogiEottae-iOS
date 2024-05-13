//
//  SearchListViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit

class SearchListViewController: UIViewController {

    let searchFilters: [SearchFilter] = [
        SearchFilter.couponDiscount,
        SearchFilter.onSale,
        SearchFilter.dayUse,
        SearchFilter.poolVilla,
        SearchFilter.breakfastFree
    ]

    let rootView = SearchListView()

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNaviBar()
        self.setDelegates()
    }

    private func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "arrow_back"))
        //self.title = "SearchListView"
    }

    private func setDelegates() {
        self.rootView.searchFilterListCollectionView.dataSource = self
        self.rootView.searchFilterListCollectionView.delegate = self
    }
}


extension SearchListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.searchFilters.count
        case 1:
            return 1
        default:
            fatalError("Invalid Section accessed")
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            guard let searchFilterListCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchFilterListCell.reuseIdentifier,
                for: indexPath
            ) as? SearchFilterListCell else { fatalError() }

            searchFilterListCell.configureData(with: self.searchFilters[indexPath.item])
            return searchFilterListCell

        case 1:
            guard let addSearchFilterListCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AddSearchFilterListCell.reuseIdentifier,
                for: indexPath
            ) as? AddSearchFilterListCell else { fatalError()}

            addSearchFilterListCell.delegate = self
            return addSearchFilterListCell

        default:
            fatalError("Invalid Section accessed")
        }

    }

}


extension SearchListViewController: UICollectionViewDelegate {

}

extension SearchListViewController: addListCellProtocol {

    func buttonDidTapped() {
        print(#function)
    }

}
