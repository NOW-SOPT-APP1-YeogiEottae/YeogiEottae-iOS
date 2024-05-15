//
//  SearchSegmentCollectionView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/14.
//

import UIKit
import SnapKit

class SearchSegmentCollectionView: UICollectionView {
    
    var currentIndex: Int = 0
    
    let underbar: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor(brightness: .gray950)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var underbarLeadingConstraint = self.underbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    private lazy var underbarTrailingConstraint = self.underbar.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.register(SearchSegmentCell.self, forCellWithReuseIdentifier: SearchSegmentCell.reuseIdentifier)
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.backgroundColor = .clear
        self.clipsToBounds = false
        
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
    
    
    private func configureViewHierarchy() {
        self.addSubview(self.underbar)
    }
    
    private func setConstraints() {
        self.underbarLeadingConstraint.isActive = true
        self.underbarTrailingConstraint.isActive = true
        self.underbar.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 39).isActive = true
        self.underbar.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func select(at selectedIndex: Int) {
        self.currentIndex = selectedIndex
        self.selectItem(at: IndexPath(item: selectedIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        // 언더바 위치 설정하는 애니메이션 설정
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.setUnderbarHorizontalLayout(to: selectedIndex)
        }
        animator.startAnimation()
    }
    
    func setUnderbarHorizontalLayout(to index: Int) {
        guard let selectedCell = self.cellForItem(at: IndexPath(item: index, section: 0)) as? SearchSegmentCell else { return }
        let label = selectedCell.segmentLabel
        let labelFrame = selectedCell.convert(label.frame, to: self)
        self.underbarLeadingConstraint.constant = labelFrame.origin.x
        self.underbarTrailingConstraint.constant = labelFrame.origin.x + label.bounds.width
        self.layoutIfNeeded()
    }
    
}
