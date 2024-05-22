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
        SearchFilter.breakfastFree,
        SearchFilter.poolVilla
    ]

    let rootView: SearchListView = SearchListView()
    let vcArray: [UIViewController] = [
        SearchResultViewController(),
        SearchResultViewController(),
        SearchResultViewController(),
        SearchResultViewController(),
        SearchResultViewController(),
        SearchResultViewController(),
        SearchResultViewController()
    ]
    
    var searchKeyword: String = "서울"
    var checkInDateInString: String = {
        guard let date = Calendar(identifier: .gregorian).date(
            from: DateComponents(year: 2024, month: 5, day: 12, weekday: 0)
        ) else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M.dd E"
        return formatter.string(from: date)
    }()
    var checkOutDateInString: String = {
        guard let date = Calendar(identifier: .gregorian).date(
            from: DateComponents(year: 2024, month: 5, day: 13, weekday: 1)
        ) else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M.dd E"
        return formatter.string(from: date)
    }()
    var headCount: Int = 2
    
    let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    lazy var segmentCollectoinView = self.rootView.segmentCollectionView
    lazy var searchFilterListCollectionView = self.rootView.searchFilterListCollectionView
    
    lazy var pageViewControllerTopConstraint = self.pageViewController.view.topAnchor.constraint(equalTo: self.rootView.filterView.bottomAnchor)
    
    var isTableViewScrollToTopEnable: Bool = true
    
    
    //MARK: UINavigationBar UIComponents
    
    let arowBackButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "arrowBack")
        configuration.baseForegroundColor = UIColor.init(hexCode: "#1C1B1F")
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    let searchAgainButton: UIButton = {
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.projectFont(name: .h1)
            outgoing.foregroundColor = UIColor.grayColor(brightness: .gray950)
            return outgoing
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "cancel")
        configuration.imagePadding = 4
        configuration.imagePlacement = .trailing
        configuration.titleTextAttributesTransformer = transformer
        configuration.contentInsets = NSDirectionalEdgeInsets.zero
        
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.arowBackButton, self.searchAgainButton])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var customBarButtonItem = UIBarButtonItem(customView: stackView)
    
    let showMapButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.SearchListView.showMapButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b3)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        return button
    }()
    
    lazy var showMapBarButtonItem = UIBarButtonItem(customView: showMapButton)
    
    let shrinkedNavigationItemTitleView = UIView()
    
    let shrinkedNavigationBarSearchPlaceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b5)
        label.textColor = UIColor.grayColor(brightness: .gray950)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    let shrinkedNavigationBarSearchRangeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l6)
        label.textColor = UIColor.grayColor(brightness: .gray800)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    /*
     NavigationBar UI Components 끝
     */
    
    let stickyViewBottomShadow: UIView = {
        let view = UIView()
        view.setGradient(firstColor: UIColor.grayColor(brightness: .gray400), secondColor: UIColor.grayColor(brightness: .gray200), axis: .vertical)
        view.isHidden = true
        return view
    }()
    
    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HotelDetailService.shared.getHotelDetailData(hotelID: 1) { result in
            switch result {
                
            case .success(let data):
                guard let hotelDetail = data as? GetHotelDetailResponseDTO else { return }
                print("성공!!!!")
                print(hotelDetail)
            case .requestErr:
                fatalError()
            case .decodedErr:
                fatalError()
            case .pathErr:
                fatalError()
            case .serverErr:
                fatalError()
            case .networkFail:
                fatalError()
            }
        }
        
        self.setPageVC()
        self.configureViewHierarchy()
        self.setConstraints()
        self.setInitialNavigationBar()
        self.updateSearchCondition()
        self.setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.stickyViewBottomShadow.setGradient(
            firstColor: UIColor.grayColor(brightness: .gray500).withAlphaComponent(0.1),
            secondColor: UIColor.grayColor(brightness: .gray500).withAlphaComponent(0),
            axis: .vertical
        )
    }
    
    private func setInitialNavigationBar() {
        self.navigationItem.leftBarButtonItem = customBarButtonItem
        self.shrinkedNavigationItemTitleView.isHidden = true
        self.navigationItem.titleView = self.shrinkedNavigationItemTitleView
        self.navigationItem.rightBarButtonItem = showMapBarButtonItem
    }

    private func setNavigationBarWhenSegmentExpanded() {
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.shrinkedNavigationItemTitleView.isHidden = true
            self.searchAgainButton.alpha = 1
        }
        animator.startAnimation()
    }
    
    private func setNavigationBarWhenSegmentShrinked() {
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.shrinkedNavigationItemTitleView.isHidden = false
            self.searchAgainButton.alpha = 0
        }
        animator.startAnimation()
    }
    
    func expand() {
        self.rootView.expandSegmentController()
        self.setNavigationBarWhenSegmentExpanded()
        self.stickyViewBottomShadow.isHidden = true
    }
    
    func shrink() {
        self.rootView.shrinkSegmentController()
        self.setNavigationBarWhenSegmentShrinked()
        self.stickyViewBottomShadow.isHidden = false
    }
    
    private func setPageVC() {
        self.pageViewController.setViewControllers([self.vcArray[0]], direction: .forward, animated: false)
    }
    
    private func configureViewHierarchy() {
        self.view.addSubviews(self.pageViewController.view, self.stickyViewBottomShadow) //view 추가 순서 주의!
        self.shrinkedNavigationItemTitleView.addSubview(self.shrinkedNavigationBarSearchPlaceLabel)
        self.shrinkedNavigationItemTitleView.addSubview(self.shrinkedNavigationBarSearchRangeLabel)
    }
    
    private func setConstraints() {
        self.shrinkedNavigationItemTitleView.snp.makeConstraints { make in
            if let navigationBarHeight = self.navigationController?.navigationBar.bounds.height {
                make.height.equalTo(navigationBarHeight)
            }
        }
        
        self.shrinkedNavigationBarSearchPlaceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.shrinkedNavigationBarSearchRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.shrinkedNavigationBarSearchPlaceLabel.snp.bottom)
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.pageViewControllerTopConstraint.isActive = true
        self.pageViewController.view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.stickyViewBottomShadow.snp.makeConstraints { make in
            make.top.equalTo(self.rootView.filterView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(3)
        }
    }
    
    private func updateSearchCondition() {
        self.searchAgainButton.setTitle(self.searchKeyword, for: .normal)
        self.shrinkedNavigationBarSearchPlaceLabel.text = self.searchKeyword
        self.shrinkedNavigationBarSearchRangeLabel.text = 
        "\(self.checkInDateInString) - \(self.checkOutDateInString), \(self.headCount)명"
        
        self.rootView.dateButton.setTitle("\(self.checkInDateInString) - \(self.checkOutDateInString)", for: .normal)
        self.rootView.headCountButton.setTitle("\(self.headCount)명", for: .normal)
    }

    private func setDelegates() {
        self.rootView.segmentCollectionView.dataSource = self
        self.rootView.segmentCollectionView.delegate = self
        
        self.rootView.searchFilterListCollectionView.dataSource = self
        self.rootView.searchFilterListCollectionView.delegate = self
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        
        self.vcArray.forEach { viewController in
            if let searchListViewController = viewController as? SearchResultViewController {
                searchListViewController.rootView.setTableViewDelegateDelegate(to: self)
            }
        }
    }
    
}

//MARK: UICollectionDataSource
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

//MARK: UICollectionViewDelegate
extension SearchListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.segmentCollectoinView:
            self.segmentCollectoinView.select(at: indexPath.item)
            
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

//MARK: UITableViewDelegate
extension SearchListViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UITableView else { return }
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        
        if velocity.y < -0 && scrollView.contentOffset.y >= 50 {
            self.shrink()
        } else if velocity.y > 500 || scrollView.contentOffset.y <= 0 {
            self.expand()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView is UITableView else { return }
        if velocity.y > 0 {
            self.shrink()
        } else if velocity.y < 0 {
            self.expand()
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        print(#function)
        guard self.isTableViewScrollToTopEnable else { return false }
        self.expand()
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(#function)
        guard let searchResultHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchResultHeaderView.reuseIdentifier) as? SearchResultHeaderView else { fatalError() }
        
        return searchResultHeaderView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hotelDetailViewController = HotelDetailViewController()
        
        HotelDetailService.shared.getHotelDetailData(hotelID: indexPath.row + 1) { result in
            switch result {
            case .success(let data):
                guard let hotelDetailData = data as? GetHotelDetailResponseDTO else { return }
            case .networkFail:
                fatalError()
            case .requestErr:
                fatalError()
            case .decodedErr:
                fatalError()
            case .pathErr:
                fatalError()
            case .serverErr:
                fatalError()
            }
        }
        
        
        self.navigationController?.pushViewController(hotelDetailViewController, animated: true)
    }
    
}

//MARK: AddListCellProtocol
extension SearchListViewController: AddListCellProtocol {

    func buttonDidTapped() {
        print(#function)
    }

}

//MARK: UIPageViewControllerDataSource
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

//MARK: UIPageViewControllerDelegate
extension SearchListViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.isTableViewScrollToTopEnable = false
        self.expand()
        let currentIndex = self.vcArray.firstIndex(of: self.pageViewController.viewControllers![0])!
        let toIndex = self.vcArray.firstIndex(of: pendingViewControllers[0])!
        if toIndex < currentIndex {
            self.segmentCollectoinView.select(at: toIndex)
        } else {
            self.segmentCollectoinView.select(at: currentIndex)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        self.isTableViewScrollToTopEnable = true
        let index = self.vcArray.firstIndex(of: self.pageViewController.viewControllers![0])!
        self.segmentCollectoinView.select(at: index)
    }
    
}
