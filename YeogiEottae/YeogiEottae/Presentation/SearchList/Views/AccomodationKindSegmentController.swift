//
//  AccomodationKindSegmentController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit
import SnapKit

final class AccomodationKindSegmentController: UIScrollView {
    
    lazy var buttonsArray: [UIButton] = [
        self.allKindButton,
        self.motelButton,
        self.hotelResortButton,
        self.pensionButton,
        self.homeVillaButton,
        self.campingButton,
        self.guestHouseHanokButton
    ]
    
    var currentIndex: Int = 0
    
//    let allKindLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.allKind
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let allKindButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.allKind, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 0
        return button
    }()
    
//    let motelLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.motel
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let motelButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.motel, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 1
        return button
    }()
    
//    let hotelResortLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.hotelResort
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let hotelResortButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.hotelResort, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 2
        return button
    }()
    
//    let pensionLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.pension
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let pensionButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.pension, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 3
        return button
    }()
    
//    let homeVillaLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.homeVilla
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let homeVillaButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.homeVilla, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 4
        return button
    }()
    
//    let campingLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.camping
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let campingButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.camping, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 5
        return button
    }()
    
//    let guestHouseHanokLabel: UILabel = {
//        let label = UILabel()
//        label.text = StringLiteral.AccomodationKindSegmentName.guestHouseHanok
//        label.textColor = .black
//        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
//        return label
//    }()
    
    let guestHouseHanokButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.AccomodationKindSegmentName.guestHouseHanok, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        button.setTitleColor(UIColor.grayColor(brightness: .gray950), for: .normal)
        button.tag = 6
        return button
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
    let underbar: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor(brightness: .gray950)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var underbarLeadingConstraint = self.underbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
    private lazy var underbarTrailingConstraint = self.underbar.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    
    private func configureViewHierarchy() {
//        self.addSubviews(
//            self.allKindLabel,
//            self.motelLabel,
//            self.hotelResortLabel,
//            self.pensionLabel,
//            self.homeVillaLabel,
//            self.campingLabel,
//            self.guestHouseHanokLabel,
//            self.seperator
//        )
        
        self.buttonsArray.forEach { button in
            self.addSubviews(button)
        }
        
        self.addSubviews(self.seperator)
        self.addSubviews(self.underbar)
        
//        self.addSubviews(
//            self.allKindButton,
//            self.motelButton,
//            self.hotelResortButton,
//            self.pensionButton,
//            self.homeVillaButton,
//            self.campingButton,
//            self.guestHouseHanokButton,
//            self.seperator
//        )
    }
    
    private func setConstraints() {
//        self.allKindLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalToSuperview().inset(24)
//            make.height.equalTo(19)
//        }
        
        self.allKindButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(19)
        }
        
//        self.motelLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.allKindLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//        }
        
        self.motelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.allKindButton.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
//        self.hotelResortLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.motelLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//        }
        
        self.hotelResortButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.motelButton.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
//        self.pensionLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.hotelResortLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//        }
        
        self.pensionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.hotelResortButton.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
//        self.homeVillaLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.pensionLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//        }
        
        self.homeVillaButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.pensionButton.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
//        self.campingLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.homeVillaLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//        }
        
        self.campingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.homeVillaButton.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
//        self.guestHouseHanokLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().inset(8)
//            make.bottom.equalToSuperview().inset(13)
//            make.leading.equalTo(self.campingLabel.snp.trailing).offset(24)
//            make.height.equalTo(19)
//            make.trailing.equalToSuperview().inset(24)
//        }
        
        self.guestHouseHanokButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.campingButton.snp.trailing).offset(24)
            make.height.equalTo(19)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.seperator.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.underbarLeadingConstraint.isActive = true
        self.underbarTrailingConstraint.isActive = true
        self.underbar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1).isActive = true
        self.underbar.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func select(at index: Int) {
        /*
         하드코딩 멈춰!
         */
        let buttonCount = 7
        //guard buttonCount > 0 else { return }
        for i in 0..<buttonCount {
            let selectedButton = self.buttonsArray[i]
            selectedButton.isSelected = (i == index) ? true : false
            selectedButton.titleLabel?.font = selectedButton.isSelected ? UIFont.projectFont(name: .b1) : UIFont.projectFont(name: .b2)
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
        let selectedButton = self.buttonsArray[index]
        guard let buttonLabel = selectedButton.titleLabel else { return }
        let buttonLabelFrame = selectedButton.convert(buttonLabel.frame, to: self)
        self.underbarLeadingConstraint.constant = buttonLabelFrame.origin.x
        self.underbarTrailingConstraint.constant = buttonLabelFrame.origin.x + buttonLabel.bounds.width
        self.layoutIfNeeded()
    }
    
    
}
