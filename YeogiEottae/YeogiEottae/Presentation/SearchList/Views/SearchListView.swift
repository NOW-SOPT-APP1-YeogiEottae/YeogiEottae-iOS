//
//  SearchListView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit
import SnapKit

final class SearchListView: UIView {
    
    private (set) var isNaviBarShrinked: Bool = false
    
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
        button.imageView?.contentMode = .scaleAspectFit
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.grayColor(brightness: .gray400).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let segmentCollectionView: SearchSegmentCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 24
        flowLayout.sectionInset.top = 0
        flowLayout.sectionInset.left = 24
        flowLayout.sectionInset.right = 24
        flowLayout.sectionInset.bottom = 0
        flowLayout.estimatedItemSize = CGSize(width: 30, height: 40)
        
        let collectionView = SearchSegmentCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SearchSegmentCell.self, forCellWithReuseIdentifier: SearchSegmentCell.reuseIdentifier)
        collectionView.scrollsToTop = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
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
        button.setTitle(StringLiteral.SearchList.filter, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.grayColor(brightness: .gray900).cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    let setOrderButtonInFilterView: UIButton = {
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
        button.setTitle(StringLiteral.SearchListView.SortButtonTitle, for: .normal)
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
        flowLayout.minimumLineSpacing = 12
        flowLayout.estimatedItemSize = CGSize(width: 30, height: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset.left = 14
        collectionView.contentInset.right = 14
        collectionView.register(SearchFilterListCell.self, forCellWithReuseIdentifier: SearchFilterListCell.reuseIdentifier)
        collectionView.register(AddSearchFilterListCell.self, forCellWithReuseIdentifier: AddSearchFilterListCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
        collectionView.scrollsToTop = false
        return collectionView
    }()
    
    let filterViewSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
    lazy var dateButtonTopConstraint = self.dateButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8)
    lazy var dateButtonHeightConstraint = self.dateButton.heightAnchor.constraint(equalToConstant: 38)
    
    lazy var segmentCollectionViewTopContraint = self.segmentCollectionView.topAnchor.constraint(equalTo: self.dateButton.bottomAnchor, constant: 16)
    lazy var segmentCollectionViewHeightConstraint = self.segmentCollectionView.heightAnchor.constraint(equalToConstant: 39)
    lazy var seperatorHeightConstraint = self.seperator.heightAnchor.constraint(equalToConstant: 1)
    
    lazy var filterButtonWidthConstraint = self.filterButton.widthAnchor.constraint(equalToConstant: 61)
    
    lazy var setOrderButtonInFilterViewLeadingConstraint = self.setOrderButtonInFilterView.leadingAnchor.constraint(equalTo: self.filterButton.trailingAnchor)
    lazy var setOrderButtonInFilterViewTrailingConstraint = self.setOrderButtonInFilterView.trailingAnchor.constraint(equalTo: self.searchFilterListCollectionView.leadingAnchor)
    lazy var setOrderButtonInFilterViewWidthConstraint = self.setOrderButtonInFilterView.widthAnchor.constraint(equalToConstant: 0)
    
    lazy var searchFilterListCollectionViewWidthConstraint = self.searchFilterListCollectionView.widthAnchor.constraint(equalToConstant: 300)
    lazy var searchFilterLeadingConstraintToSetOrderButton = self.searchFilterListCollectionView.leadingAnchor.constraint(equalTo: self.setOrderButtonInFilterView.trailingAnchor)
    lazy var searchFilterLeadingConstraintToTrailing = self.searchFilterListCollectionView.leadingAnchor.constraint(equalTo: self.searchFilterListCollectionView.trailingAnchor)
    
    lazy var filterViewSeperatorHeightConstraint = self.filterViewSeperator.heightAnchor.constraint(equalToConstant: 1)
    
    var screenSize: CGSize? {
        guard let screen = self.window?.windowScene?.screen else { return nil }
        return screen.bounds.size
    }
    
    
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
        self.addSubviews(self.dateButton, self.headCountButton)
        self.addSubviews(self.segmentCollectionView, self.seperator)
        self.filterView.addSubviews(self.filterButton, self.setOrderButtonInFilterView, self.searchFilterListCollectionView, self.filterViewSeperator)
        self.addSubview(self.filterView)
    }
    
    private func setConstraints() {
        
        self.dateButtonTopConstraint.isActive = true
        self.dateButtonHeightConstraint.isActive = true
        self.dateButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
        }
        
        self.headCountButton.snp.makeConstraints {
            $0.top.equalTo(self.dateButton.snp.top)
            $0.leading.equalTo(self.dateButton.snp.trailing).offset(8)
            $0.height.equalTo(self.dateButton.snp.height)
        }
        
        self.segmentCollectionViewTopContraint.isActive = true
        self.segmentCollectionViewHeightConstraint.isActive = true
        self.segmentCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
        
        self.seperatorHeightConstraint.isActive = true
        self.seperator.snp.makeConstraints { make in
            make.top.equalTo(self.segmentCollectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        self.filterView.snp.makeConstraints { make in
            make.top.equalTo(self.seperator.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(38)
        }
        
        self.filterButtonWidthConstraint.isActive = true
        self.filterButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            //make.width.equalTo(61)
            make.height.equalTo(31)
        }
        
        self.setOrderButtonInFilterViewLeadingConstraint.isActive = true
        self.setOrderButtonInFilterViewTrailingConstraint.isActive = true
        self.setOrderButtonInFilterViewWidthConstraint.isActive = true
        self.setOrderButtonInFilterView.snp.makeConstraints { make in
            make.top.equalTo(self.filterButton)
            make.height.equalTo(self.filterButton)
        }
        
        self.searchFilterLeadingConstraintToSetOrderButton.isActive = true
        self.searchFilterLeadingConstraintToTrailing.isActive = false
        self.searchFilterListCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        self.filterViewSeperatorHeightConstraint.isActive = true
        self.filterViewSeperator.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func shrinkSegmentController() {
        guard !self.isNaviBarShrinked else { return }
        self.segmentCollectionView.underbar.isHidden = true
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1)
        animator.addAnimations { [weak self] in
            guard let self else { return }
            self.dateButtonTopConstraint.constant = 4
            self.dateButtonHeightConstraint.constant = 0
            
            self.segmentCollectionViewTopContraint.constant = 0
            self.segmentCollectionViewHeightConstraint.constant = 1
            self.seperatorHeightConstraint.constant = 0
            
            if let screenSize = self.screenSize {
                self.filterButtonWidthConstraint.constant = (screenSize.width - (24 + 24 + 12)) / 2
            }
            
            self.setOrderButtonInFilterViewLeadingConstraint.constant = 12
            self.setOrderButtonInFilterViewTrailingConstraint.constant = -24
            self.setOrderButtonInFilterViewWidthConstraint.isActive = false
            self.setOrderButtonInFilterView.alpha = 1
            
            self.searchFilterLeadingConstraintToSetOrderButton.isActive = false
            self.searchFilterLeadingConstraintToTrailing.isActive = true
            
            self.filterViewSeperatorHeightConstraint.constant = 0
            self.layoutIfNeeded()
        }
        animator.addCompletion { _ in
            self.isNaviBarShrinked = true
        }
        animator.startAnimation()
        
    }
    
    
    func expandSegmentController() {
        guard self.isNaviBarShrinked else { return }
        self.segmentCollectionView.underbar.isHidden = false
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1)
        animator.addAnimations {
            self.dateButtonTopConstraint.constant = 8
            self.dateButtonHeightConstraint.constant = 38
            
            self.segmentCollectionViewTopContraint.constant = 16
            self.segmentCollectionViewHeightConstraint.constant = 39
            self.seperatorHeightConstraint.constant = 1
            
            self.filterButtonWidthConstraint.constant = 61
            
            self.setOrderButtonInFilterViewLeadingConstraint.constant = 0
            self.setOrderButtonInFilterViewTrailingConstraint.constant = 0
            self.setOrderButtonInFilterViewWidthConstraint.isActive = true
            self.setOrderButtonInFilterView.alpha = 0
            
            self.searchFilterLeadingConstraintToSetOrderButton.isActive = true
            self.searchFilterLeadingConstraintToTrailing.isActive = false
            
            self.filterViewSeperatorHeightConstraint.constant = 1
            self.layoutIfNeeded()
        }
        animator.addCompletion { _ in
            self.isNaviBarShrinked = false
        }
        animator.startAnimation()
        
    }
    
    
}
