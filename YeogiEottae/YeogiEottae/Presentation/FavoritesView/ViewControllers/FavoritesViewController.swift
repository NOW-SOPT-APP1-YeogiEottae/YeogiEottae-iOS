//
//  FavoritesViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var isRoomFavorite: [Bool] = [true, true, false, true, false]
    
    let rootView: FavoritesView = FavoritesView()
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegates()
    }
    
    
    private func setDelegates() {
        self.rootView.favoritesCollectionView.dataSource = self
        self.rootView.favoritesCollectionView.delegate = self
    }
    
    
}

extension FavoritesViewController: UICollectionViewDataSource {
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

extension FavoritesViewController: UICollectionViewDelegate {
    
}


extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let screenWidth = self.rootView.window?.windowScene?.screen.bounds.width else { fatalError() }
        let cellWidth = screenWidth - (19 * 2)
        
        if self.isRoomFavorite[indexPath.item] {
            return CGSize(width: cellWidth, height: 379)
        } else {
            return CGSize(width: cellWidth, height: 139)
        }
        
    }
    
}
