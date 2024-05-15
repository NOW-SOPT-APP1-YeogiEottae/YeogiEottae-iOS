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
    let vcArray = [
        OrangeViewController(),
        GreenViewController(),
        BlueViewController(),
        OrangeViewController(),
        GreenViewController(),
        BlueViewController(),
        OrangeViewController()
    ]
    let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    //lazy var customSegmentController: AccomodationKindSegmentController = self.rootView.customSegmentController
    lazy var segmentCollectoinView = self.rootView.segmentCollectionView
    lazy var searchFilterListCollectionView = self.rootView.searchFilterListCollectionView
    
    lazy var pageViewControllerTopConstraint = self.pageViewController.view.topAnchor.constraint(equalTo: self.rootView.filterView.bottomAnchor)
    
    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNaviBar()
        self.setPageVC()
        self.configureViewHierarchy()
        self.setConstraints()
        self.setDelegates()
    }

    private func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "arrow_back"))
    }
    
    private func setPageVC() {
        self.pageViewController.setViewControllers([self.vcArray[0]], direction: .forward, animated: false)
    }
    
    private func configureViewHierarchy() {
        self.view.addSubview(self.pageViewController.view)
    }
    
    private func setConstraints() {
        self.pageViewControllerTopConstraint.isActive = true
        self.pageViewController.view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
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
            
            var isForward: UIPageViewController.NavigationDirection {
                let currentIndex = self.vcArray.firstIndex(of: self.pageViewController.viewControllers![0])!
                if currentIndex <= indexPath.item {
                    return .forward
                } else {
                    return .reverse
                }
            }
            self.pageViewController.setViewControllers([self.vcArray[indexPath.item]], direction: isForward, animated: true)
            
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


extension SearchListViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.vcArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return self.vcArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.vcArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex >= self.vcArray.count { return nil }
        return self.vcArray[nextIndex]
    }
    
}

extension SearchListViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(#function)
        let currentIndex = self.vcArray.firstIndex(of: self.pageViewController.viewControllers![0])!
        let toIndex = self.vcArray.firstIndex(of: pendingViewControllers[0])!
        print("toIndex:", toIndex)
        //self.selectSegmentButton(index: index)
        if toIndex < currentIndex {
            self.segmentCollectoinView.select(at: toIndex)
        } else {
            self.segmentCollectoinView.select(at: currentIndex)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print(#function)
        let index = self.vcArray.firstIndex(of: self.pageViewController.viewControllers![0])!
        print(index)
        //self.selectSegmentButton(index: index)
        self.segmentCollectoinView.select(at: index)
    }
    
}
