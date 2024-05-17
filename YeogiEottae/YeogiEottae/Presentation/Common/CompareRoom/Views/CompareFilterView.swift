//
//  CompareFilterView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class CompareFilterView: UIView, UIScrollViewDelegate {
    
    weak var delegate: CompareTopViewCellDelegate?
    
    let stickyView: UIView = {
        let view = UIView()
        view.makeBorder(width: 1, color: .grayColor(brightness: .gray200))
        return view
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.makeBorder(width: 1, color: .grayColor(brightness: .gray200))
        return scrollView
    }()
    
    let lowPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("낮은 가격 순", for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    let highPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("높은 평점 순", for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    let highDiscountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("높은 할인 순", for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: -4)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    let facilityLabel: UILabel = {
        let label = UILabel()
        label.text = "부대 시설"
        label.font = UIFont.projectFont(name: .b6)
        label.textColor = UIColor.grayColor(brightness: .gray800)
        label.textAlignment = .right
        return label
    }()
    
    let roomHotelLabel: UILabel = {
        let label = UILabel()
        label.text = "객실 및 호텔"
        label.font = UIFont.projectFont(name: .b6)
        label.textColor = UIColor.grayColor(brightness: .gray800)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setHierarchy()
        setConstraints()
        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.compareTopViewCellDidScroll(self, scrollView: scrollView)
    }
    
    private func setHierarchy() {
        self.addSubviews(stickyView, scrollView)
        stickyView.addSubview(roomHotelLabel)
        scrollView.addSubviews(lowPriceButton, highPriceButton, highDiscountButton, facilityLabel)
    }
    
    private func setConstraints() {
        stickyView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(137)
        }
        
        scrollView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(stickyView.snp.trailing)
        }
        
        roomHotelLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(29)
        }

        lowPriceButton.snp.makeConstraints {
            $0.leading.equalTo(scrollView.contentLayoutGuide).offset(12)
            $0.width.equalTo(88)
            $0.height.equalTo(48)
        }
        
        highPriceButton.snp.makeConstraints {
            $0.leading.equalTo(lowPriceButton.snp.trailing).offset(40)
            $0.width.equalTo(88)
            $0.height.equalTo(48)
        }
        
        highDiscountButton.snp.makeConstraints {
            $0.leading.equalTo(highPriceButton.snp.trailing).offset(40)
            $0.width.equalTo(88)
            $0.height.equalTo(48)
        }
        
        facilityLabel.snp.makeConstraints { make in
            make.leading.equalTo(highDiscountButton.snp.trailing).offset(40)
            make.trailing.equalTo(scrollView.contentLayoutGuide).inset(38)
            make.width.equalTo(152)
            make.centerY.equalToSuperview()
        }
    }
}

