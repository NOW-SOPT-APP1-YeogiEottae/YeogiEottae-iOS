//
//  FavoritesCollectionViewController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/19.
//

import UIKit

import Moya

class FavoritesCollectionViewController: UIViewController {
    
    var isRoomFavorite: [Bool] = [true, true, false, true, false]
    
    let provier = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    var favoriteContentsArray: [FavoriteContentDTO] = [] {
        didSet {
            DispatchQueue.main.async {
                self.favoritesCollectionView.reloadData()
            }
        }
    }
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.provier.request(.getFavoritesListData) { result in
            
            print(Thread().isMainThread)
            
            switch result {
            case .success(let response):
                let data = response.data
                let decoder = JSONDecoder()
                guard let getFavoritesListDTO = try? JSONDecoder().decode(GetFavoritesListResponseDTO.self, from: data) else { return }
                let favoriteContentsArray = getFavoritesListDTO.result
                self.favoriteContentsArray = favoriteContentsArray
            case .failure(let moyaError):
                fatalError(moyaError.localizedDescription)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        return self.favoriteContentsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let favoriteContent = self.favoriteContentsArray[indexPath.item]
        
        switch favoriteContent.roomInformation != nil {
        case true:
            guard let favoritesRoomCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesRoomCell.reuseIdentifier, for: indexPath) as? FavoritesRoomCell else { fatalError() }
            
            favoritesRoomCell.configureData(
                roomID: favoriteContent.roomInformation!.roomID,
                accommodationlName: favoriteContent.hotelName,
                rating: favoriteContent.reviewRate,
                roomName: favoriteContent.roomInformation!.roomName, //switch문을 통해 roomInformation != nil임을 확인했으므로 강제 언래핑
                price: favoriteContent.roomInformation!.price,
                imageURL: favoriteContent.roomInformation!.roomImageURL
            )
            
            return favoritesRoomCell
        case false:
            
            guard let favoritesAccommodationCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesAccommodationCell.reuseIdentifier, for: indexPath) as? FavoritesAccommodationCell else { fatalError() }
            
            favoritesAccommodationCell.configureData(
                accommodationlName: favoriteContent.hotelName,
                rating: favoriteContent.reviewRate
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
        let favoriteContent = self.favoriteContentsArray[indexPath.item]
        
        if favoriteContent.roomInformation != nil {
            return CGSize(width: cellWidth, height: 379)
        } else {
            return CGSize(width: cellWidth, height: 139)
        }
        
    }
    
}
