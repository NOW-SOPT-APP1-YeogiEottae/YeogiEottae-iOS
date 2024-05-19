//
//  FavoritesViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

class FavoritesViewController: UIViewController {
    
//    var isRoomFavorite: [Bool] = [true, true, false, true, false]
    
    let rootView: FavoritesView = FavoritesView()
    
    let favoritesSegmentStackView = FavoritesSegmentStackView()
    
    let viewControllerArray: [UIViewController] = [
        FavoritesCollectionViewController(),
        FavoritesCollectionViewController(),
        FavoritesCollectionViewController(),
        FavoritesCollectionViewController()
    ]
    let pageViewController: UIPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewHierarchy()
        self.setNavigationBar()
        self.setConstraints()
        self.setDelegates()
        self.setPageViewController()
        self.setButtonsAction()
    }
    
    private func configureViewHierarchy() {
        self.view.addSubview(self.pageViewController.view)
    }
    
    private func setNavigationBar() {
        self.navigationItem.titleView = self.favoritesSegmentStackView
    }
    
    private func setConstraints() {
        self.favoritesSegmentStackView.snp.makeConstraints { [weak self] make in
            guard let self else { return }
            if let navigationBarSize = self.navigationController?.navigationBar.bounds {
                make.width.equalTo(navigationBarSize.width)
                make.height.equalTo(navigationBarSize.height)
            }
        }
        
        self.pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(self.rootView.fixedHeaderView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setDelegates() {
        //self.rootView.favoritesCollectionView.dataSource = self
        //self.rootView.favoritesCollectionView.delegate = self
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
    }
    
    private func setPageViewController() {
        self.pageViewController.setViewControllers([self.viewControllerArray[0]], direction: .forward, animated: false)
        
    }
    
    private func setButtonsAction() {
        self.favoritesSegmentStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else { return }
            button.addTarget(self, action: #selector(favoritesSegmentButtonDidTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc private func favoritesSegmentButtonDidTapped(sender: UIButton) {
        
        self.favoritesSegmentStackView.select(at: sender.tag)
        
        var isForward: UIPageViewController.NavigationDirection {
            let currentIndex = self.viewControllerArray.firstIndex(of: self.pageViewController.viewControllers![0])!
            if currentIndex <= sender.tag {
                return .forward
            } else {
                return .reverse
            }
        }
        
        switch sender.tag {
        case 0:
            self.pageViewController.setViewControllers([self.viewControllerArray[0]], direction: isForward, animated: true)
        case 1:
            self.pageViewController.setViewControllers([self.viewControllerArray[1]], direction: isForward, animated: true)
        case 2:
            self.pageViewController.setViewControllers([self.viewControllerArray[2]], direction: isForward, animated: true)
        case 3:
            self.pageViewController.setViewControllers([self.viewControllerArray[3]], direction: isForward, animated: true)
        case 4:
            self.pageViewController.setViewControllers([self.viewControllerArray[4]], direction: isForward, animated: true)
        default:
            return
        }
    }
    
}

//extension FavoritesViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        
//        switch self.isRoomFavorite[indexPath.item] {
//        case true:
//            guard let favoritesRoomCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesRoomCell.reuseIdentifier, for: indexPath) as? FavoritesRoomCell else { fatalError() }
//            
//            favoritesRoomCell.configureData(
//                accommodationlName: "그랜드 인터컨티넨탈 파르나스",
//                rating: 9.4,
//                roomName: "스탠다드 트윈룸",
//                price: 90000
//            )
//            
//            return favoritesRoomCell
//        case false:
//            
//            guard let favoritesAccommodationCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesAccommodationCell.reuseIdentifier, for: indexPath) as? FavoritesAccommodationCell else { fatalError() }
//            
//            favoritesAccommodationCell.configureData(
//                accommodationlName: "그랜드 인터컨티넨탈 파르나스",
//                rating: 9.4
//            )
//            
//            return favoritesAccommodationCell
//            
//        }
//        
//        
//    }
//}
//
//extension FavoritesViewController: UICollectionViewDelegate {
//    
//}
//
//
//extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        guard let screenWidth = self.rootView.window?.windowScene?.screen.bounds.width else { fatalError() }
//        let cellWidth = screenWidth - (19 * 2)
//        
//        if self.isRoomFavorite[indexPath.item] {
//            return CGSize(width: cellWidth, height: 379)
//        } else {
//            return CGSize(width: cellWidth, height: 139)
//        }
//        
//    }
//    
//}


extension FavoritesViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.viewControllerArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return self.viewControllerArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.viewControllerArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex >= self.viewControllerArray.count { return nil }
        return self.viewControllerArray[nextIndex]
    }
    
}


extension FavoritesViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let index = self.viewControllerArray.firstIndex(of: self.pageViewController.viewControllers![0])!
        //self.selectSegmentButton(index: index)
        self.favoritesSegmentStackView.select(at: index)
    }
    
}
