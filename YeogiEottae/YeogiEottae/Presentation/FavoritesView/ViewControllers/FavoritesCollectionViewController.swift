//
//  FavoritesCollectionViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/19.
//

import UIKit

class FavoritesCollectionViewController: UIViewController {
    
    var isRoomFavorite: [Bool] = [true, true, false, true, false]
    
    lazy var favoritesCollectionView: UICollectionView = {
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 13, left: 19, bottom: 13, right: 19)
        flowLayout.minimumLineSpacing = 12
        /*
         여기서 itemSize를 정의할 수도 있지만, indexPath별로 방인지 숙소인지 구분하여 분기처리하기 위해 itemSize를 구하는 코드는 UICollectionViewDelegateFlowLayout으로 구현함.
         */
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FavoritesRoomCell.self, forCellWithReuseIdentifier: FavoritesRoomCell.reuseIdentifier)
        collectionView.register(FavoritesAccommodationCell.self, forCellWithReuseIdentifier: FavoritesAccommodationCell.reuseIdentifier)
        collectionView.backgroundColor = .grayColor(brightness: .gray200)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewHierarchy()
        self.setConstraints()
        self.setDelegates()
    }
    
    private func configureViewHierarchy() {
        self.view.addSubview(self.favoritesCollectionView)
    }
    
    private func setConstraints() {
        
        self.favoritesCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDelegates() {
        self.favoritesCollectionView.dataSource = self
        self.favoritesCollectionView.delegate = self
    }
    
    
}


extension FavoritesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch self.isRoomFavorite[indexPath.item] {
        case true:
            guard let favoritesRoomCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesRoomCell.reuseIdentifier, for: indexPath) as? FavoritesRoomCell else { fatalError() }
            
            favoritesRoomCell.configureData(
                accommodationlName: "그랜드 인터컨티넨탈 파르나스",
                rating: 9.4,
                roomName: "스탠다드 트윈룸",
                price: 90000
            )
            
            return favoritesRoomCell
        case false:
            
            guard let favoritesAccommodationCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesAccommodationCell.reuseIdentifier, for: indexPath) as? FavoritesAccommodationCell else { fatalError() }
            
            favoritesAccommodationCell.configureData(
                accommodationlName: "그랜드 인터컨티넨탈 파르나스",
                rating: 9.4
            )
            
            return favoritesAccommodationCell
            
        }
        
        
    }
}

extension FavoritesCollectionViewController: UICollectionViewDelegate {
    
}


extension FavoritesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let screenWidth = self.view.window?.windowScene?.screen.bounds.width else { fatalError() }
        let cellWidth = screenWidth - (19 * 2)
        
        if self.isRoomFavorite[indexPath.item] {
            return CGSize(width: cellWidth, height: 379)
        } else {
            return CGSize(width: cellWidth, height: 139)
        }
        
    }
    
}
