//
//  SearchListViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit

enum searchFilterListCollectionViewSection: Int {
    case list
    case add
}

class SearchListViewController: UIViewController {
    
    let segments = [
        StringLiteral.SearchSegmentName.allKind,
        StringLiteral.SearchSegmentName.motel,
        StringLiteral.SearchSegmentName.hotelResort,
        StringLiteral.SearchSegmentName.pension,
        StringLiteral.SearchSegmentName.homeVilla,
        StringLiteral.SearchSegmentName.camping,
        StringLiteral.SearchSegmentName.guestHouseHanok
    ]
    
    let searchFilters: [SearchFilter] = [
        SearchFilter.couponDiscount,
        SearchFilter.onSale,
        SearchFilter.dayUse,
        SearchFilter.poolVilla,
        SearchFilter.breakfastFree
    ]

    let rootView: SearchListView = SearchListView()
    
    //lazy var customSegmentController: AccomodationKindSegmentController = self.rootView.customSegmentController
    lazy var segmentCollectoinView = self.rootView.segmentCollectionView
    lazy var searchFilterListCollectionView = self.rootView.searchFilterListCollectionView
    
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
        self.rootView.segmentCollectionView.dataSource = self
        self.rootView.segmentCollectionView.delegate = self
        
        self.rootView.searchFilterListCollectionView.dataSource = self
        self.rootView.searchFilterListCollectionView.delegate = self
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
    }
    
}


extension SearchListViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        switch collectionView {
        case self.segmentCollectoinView:
            return 1
        case self.searchFilterListCollectionView:
            return 2
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch collectionView {
        case self.segmentCollectoinView:
            return 7
            
        case self.searchFilterListCollectionView:
            
            switch section {
            case searchFilterListCollectionViewSection.list.rawValue:
                return self.searchFilters.count
            case searchFilterListCollectionViewSection.add.rawValue:
                return 1
            default:
                fatalError("Invalid Section accessed")
            }
            
        default:
            return 0
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.segmentCollectoinView:
            guard let searchSegmentCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchSegmentCell.reuseIdentifier,
                for: indexPath
            ) as? SearchSegmentCell else { fatalError() }
            
            searchSegmentCell.segmentLabel.text = self.segments[indexPath.item]
            return searchSegmentCell
            
        case self.searchFilterListCollectionView:
            
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
            
        default:
            fatalError()
        }
    }
    
}


extension SearchListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        switch collectionView {
        case self.segmentCollectoinView:
            self.segmentCollectoinView.select(at: indexPath.item)
            self.segmentCollectoinView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        case self.searchFilterListCollectionView:
            return
            
        default:
            return
        }
    }
    
}

extension SearchListViewController: addListCellProtocol {

    func buttonDidTapped() {
        print(#function)
    }

}
