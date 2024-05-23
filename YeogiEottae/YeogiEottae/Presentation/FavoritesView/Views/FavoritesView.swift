//
//  FavoritesView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

final class FavoritesView: UIView {
    
    
    var screenSize: CGSize? {
        guard let screen = self.window?.windowScene?.screen else {
            print("screenSize is nil")
            return nil
        }
        return screen.bounds.size
    }
    
    let fixedHeaderView = UIView()
    
    let favoritesDayButton: UIButton = {
        // 아래 UIConfigurationTextAttributesTransformer 이라는 타입은 생성자의 매개변수로 클로저를 받는다...특이한 친구일세..
        let transformer = UIConfigurationTextAttributesTransformer.init { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.grayColor(brightness: .gray900)
            outgoing.font = UIFont.projectFont(name: .h6)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.background.backgroundColor = .grayColor(brightness: .gray200)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 30)
            configuration.imagePlacement = .leading
            configuration.imagePadding = 4
            configuration.titleTextAttributesTransformer = transformer
            configuration.image = UIImage(named: "calendar")
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("5.2 목 - 5.3 금", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    
    let favoritesHeadCountButton: UIButton = {
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.grayColor(brightness: .gray900)
            outgoing.font = UIFont.projectFont(name: .h6)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            //configuration.baseBackgroundColor = .grayColor(brightness: .gray200)
            configuration.background.backgroundColor = .grayColor(brightness: .gray200)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            configuration.imagePlacement = .leading
            configuration.imagePadding = 4
            configuration.titleTextAttributesTransformer = transformer
            configuration.image = UIImage(named: "person")
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("2명", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    let compareButton: UIButton = {
        
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.secondaryColor(brightness: .secondary600)
            outgoing.font = UIFont.projectFont(name: .h6)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.background.backgroundColor = .secondaryColor(brightness: .secondary200)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            configuration.titleTextAttributesTransformer = transformer
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.setTitle("비교하기", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    lazy var favoritesCollectionView: UICollectionView = {
        
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 13, left: 19, bottom: 13, right: 19)
        flowLayout.minimumLineSpacing = 12
        /*
         cell의 estimatedSize 는 델리게이트 패턴으로 구현(cell의 너비를 화면 너비와 맞추기 위함. 현재 단계에서는 화면 너비를 구할 수 없기 때문.)
         */
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FavoritesRoomCell.self, forCellWithReuseIdentifier: FavoritesRoomCell.reuseIdentifier)
        collectionView.register(FavoritesAccommodationCell.self, forCellWithReuseIdentifier: FavoritesAccommodationCell.reuseIdentifier)
        collectionView.backgroundColor = .grayColor(brightness: .gray200)
        
        return collectionView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        
        self.fixedHeaderView.addSubviews(
            self.favoritesDayButton,
            self.favoritesHeadCountButton,
            self.compareButton
        )
        
        self.addSubviews(
            self.fixedHeaderView
        )
    }
    
    private func setConstraints() {
        
        self.fixedHeaderView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.favoritesDayButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.equalToSuperview().inset(19)
            make.bottom.equalToSuperview().inset(16)
            //make.width.equalTo(157)
            make.height.equalTo(40)
        }
        
        self.favoritesHeadCountButton.snp.makeConstraints { make in
            make.top.equalTo(self.favoritesDayButton)
            make.leading.equalTo(self.favoritesDayButton.snp.trailing).offset(4)
            //make.width.equalTo(66)
            make.height.equalTo(self.favoritesDayButton)
            make.trailing.lessThanOrEqualTo(self.compareButton.snp.leading).offset(-10)
        }
        
        self.compareButton.snp.makeConstraints { make in
            make.top.equalTo(self.favoritesDayButton)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(self.favoritesDayButton)
        }
    }
    
    
    func estimateCollectionViewItemSize() {
        if let screenSize {
            guard let flowLayout = self.favoritesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
            flowLayout.estimatedItemSize = CGSize(width: screenSize.width - (19 * 2), height: 10)
        }
    }
    
    
    
    
}
