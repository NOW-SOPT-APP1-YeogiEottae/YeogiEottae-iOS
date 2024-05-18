//
//  FavoritesSegmentStackView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

class FavoritesSegmentStackView: UIStackView {
    
    var currentIndex: Int = 0
    
    let segmentButton0: UIButton = {
        let button = UIButton()
        button.setTitle("국내 숙소", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b5) //선택되면 h6
        button.setTitleColor(.grayColor(brightness: .gray850), for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .selected)
        button.tag = 0
        return button
    }()
    
    let segmentButton1: UIButton = {
        let button = UIButton()
        button.setTitle("해외 숙소", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b5)
        button.setTitleColor(.grayColor(brightness: .gray850), for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .selected)
        button.tag = 1
        return button
    }()
    
    let segmentButton2: UIButton = {
        let button = UIButton()
        button.setTitle("공간대여", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b5)
        button.setTitleColor(.grayColor(brightness: .gray850), for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .selected)
        button.tag = 2
        return button
    }()
    
    let segmentButton3: UIButton = {
        let button = UIButton()
        button.setTitle("레저•티켓", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b5)
        button.setTitleColor(.grayColor(brightness: .gray850), for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .selected)
        button.tag = 3
        return button
    }()
    
    let underbar: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryColor(brightness: .secondary600)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor(brightness: .gray400)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setStackViewLayout()
        self.setConstraints()
    }
    
    private lazy var underbarLeadingConstraint = self.underbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    private lazy var underbarTrailingConstraint = self.underbar.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        self.addArrangedSubviews(
            self.segmentButton0,
            self.segmentButton1,
            self.segmentButton2,
            self.segmentButton3
        )
        
        [self.separator, self.underbar].forEach { self.addSubview($0) }
    }
    
    func setStackViewLayout() {
        self.spacing = 0
        self.distribution = .fillEqually
    }
    
    func setConstraints() {
        
        self.separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.underbarLeadingConstraint.isActive = true
        self.underbarTrailingConstraint.isActive = true
        self.underbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.underbar.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func select(at index: Int) {
        let buttonCount = self.arrangedSubviews.count
        guard buttonCount > 0 else { return }
        for i in 0..<buttonCount {
            guard let button = self.arrangedSubviews[i] as? UIButton else { return }
            button.isSelected = (i == index) ? true : false
            button.titleLabel?.font = button.isSelected ? UIFont.projectFont(name: .h6) : UIFont.projectFont(name: .b5)
        }
        self.currentIndex = index
        
        // 언더바 위치 설정하는 애니메이션 설정
        let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 1)
        animator.addAnimations {
            self.setUnderbarHorizontalLayout(to: index)
        }
        animator.startAnimation()
    }
    
    
    func setUnderbarHorizontalLayout(to index: Int) {
        guard let selectedButton = self.arrangedSubviews[index] as? UIButton else { fatalError() }
        let buttonFrame = selectedButton.frame
        self.underbarLeadingConstraint.constant = buttonFrame.minX
        self.underbarTrailingConstraint.constant = buttonFrame.maxX
        self.layoutIfNeeded()
    }
    
}


//extension FavoritesSegmentStackView {
//    
//    static func getDefault() -> FavoritesSegmentStackView {
//        
//        let segmentButton0: UIButton = {
//            let button = UIButton()
//            button.setTitle("국내 숙소", for: .normal)
//            button.titleLabel?.font = UIFont.projectFont(name: .b5) //선택되면 h6
//            button.tag = 0
//            return button
//        }()
//        
//        let segmentButton1: UIButton = {
//            let button = UIButton()
//            button.setTitle("해외 숙소", for: .normal)
//            button.titleLabel?.font = UIFont.projectFont(name: .b5)
//            button.tag = 1
//            return button
//        }()
//        
//        let segmentButton2: UIButton = {
//            let button = UIButton()
//            button.setTitle("공간대여", for: .normal)
//            button.titleLabel?.font = UIFont.projectFont(name: .b5)
//            button.tag = 2
//            return button
//        }()
//        
//        let segmentButton3: UIButton = {
//            let button = UIButton()
//            button.setTitle("레저•티켓", for: .normal)
//            button.titleLabel?.font = UIFont.projectFont(name: .b5)
//            button.tag = 3
//            return button
//        }()
//        
//        let stackView = SegmentStackView(
//            arrangedSubviews: [
//                segmentButton0,
//                segmentButton1,
//                segmentButton2,
//                segmentButton3
//            ]
//        )
//        
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//        stackView.spacing = 5
//        return stackView
//        
//    }
//    
//}
