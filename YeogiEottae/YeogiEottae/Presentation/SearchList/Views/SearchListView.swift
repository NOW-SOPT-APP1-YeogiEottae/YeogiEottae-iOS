//
//  SearchListView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit
import SnapKit

final class SearchListView: UIView {
    
    let dateButton: UIButton = {
        // 아래 UIConfigurationTextAttributesTransformer 이라는 타입은 생성자의 매개변수로 클로저를 받는다...특이한 친구일세..
        let transformer = UIConfigurationTextAttributesTransformer.init { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.black
            outgoing.font = UIFont.projectFont(name: .l4)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 4
            configuration.titleTextAttributesTransformer = transformer
            configuration.image = UIImage(named: "expandMore")
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.setTitle("5.12 일 - 5.13 월", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.grayColor(brightness: .gray400).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let headCountButton: UIButton = {
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.black
            outgoing.font = UIFont.projectFont(name: .l4)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 4
            configuration.titleTextAttributesTransformer = transformer
            configuration.image = UIImage(named: "expandMore")
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.setTitle("2명", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.grayColor(brightness: .gray400).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let customSegmentController = AccomodationKindSegmentController()
    
    let filterView = UIView()
    
    let filterButton: UIButton = {
        let transformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.grayColor(brightness: .gray900)
            outgoing.font = UIFont.projectFont(name: .h6)
            return outgoing
        }
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.imagePlacement = .leading
            configuration.imagePadding = 2
            configuration.titleTextAttributesTransformer = transformer
            configuration.image = UIImage(named: "filter")?.withTintColor(UIColor.grayColor(brightness: .gray900))
            configuration.contentInsets.leading = 6
            configuration.contentInsets.trailing = 10
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.setTitle("필터", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.grayColor(brightness: .gray900).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let searchFilterListCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.minimumLineSpacing = 12
        flowLayout.estimatedItemSize = CGSize(width: 30, height: 30)
        //flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.left = 14
        collectionView.contentInset.right = 14
        collectionView.register(SearchFilterListCell.self, forCellWithReuseIdentifier: SearchFilterListCell.reuseIdentifier)
        collectionView.register(AddSearchFilterListCell.self, forCellWithReuseIdentifier: AddSearchFilterListCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        return collectionView
    }()
    
    let filterViewUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        [self.dateButton, self.headCountButton].forEach { view in self.addSubview(view) }
        self.addSubview(self.customSegmentController)
        [self.filterButton, self.searchFilterListCollectionView, self.filterViewUnderBar].forEach { view in self.filterView.addSubview(view) }
        self.addSubview(self.filterView)
    }
    
    private func setConstraints() {
        self.dateButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8)
            $0.leading.equalToSuperview().offset(19)
            $0.height.equalTo(38)
        }
        
        self.headCountButton.snp.makeConstraints {
            $0.top.equalTo(self.dateButton.snp.top)
            $0.leading.equalTo(self.dateButton.snp.trailing).offset(8)
            $0.height.equalTo(self.dateButton.snp.height)
        }
        
        self.customSegmentController.snp.makeConstraints {
            $0.top.equalTo(self.dateButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        self.filterView.snp.makeConstraints {
            $0.top.equalTo(self.customSegmentController.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        self.filterButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
            $0.width.equalTo(61)
            $0.height.equalTo(31)
        }
        
        self.searchFilterListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(self.filterButton.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        
        self.filterViewUnderBar.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    
    
}
