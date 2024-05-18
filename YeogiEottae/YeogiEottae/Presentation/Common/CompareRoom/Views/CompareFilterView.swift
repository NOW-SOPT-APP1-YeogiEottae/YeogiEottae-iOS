//
//  CompareFilterView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit


final class CompareFilterView: UIView, UIScrollViewDelegate {
    
    weak var delegate: CompareFilterViewCellDelegate?
    
    private let stickyView: UIView = {
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
    
    private let lowPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringLiteral.CompareFilter.lowPrice, for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let highPriceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringLiteral.CompareFilter.highRate, for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let highDiscountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringLiteral.CompareFilter.highDiscount, for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b6)
        button.setImage(UIImage.expandMore, for: .normal)
        button.tintColor = UIColor.grayColor(brightness: .gray800)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let facilityLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.CompareFilter.facility
        label.font = UIFont.projectFont(name: .b6)
        label.textColor = UIColor.grayColor(brightness: .gray800)
        label.textAlignment = .right
        return label
    }()
    
    private let roomHotelLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.CompareFilter.roomHotel
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
        delegate?.compareFilterViewCellDidScroll(self, scrollView: scrollView)
    }
    
    private func setHierarchy() {
        self.addSubviews(stickyView, scrollView)
        stickyView.addSubview(roomHotelLabel)
        scrollView.addSubviews(lowPriceButton, highPriceButton, highDiscountButton, facilityLabel)
    }
    
    private func setConstraints() {
        stickyView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(137)
        }
        
        scrollView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(stickyView.snp.trailing)
        }
        
        roomHotelLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(29)
        }
        
        lowPriceButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.width.equalTo(88)
            $0.verticalEdges.equalToSuperview()
        }
        
        highPriceButton.snp.makeConstraints {
            $0.leading.equalTo(lowPriceButton.snp.trailing).offset(40)
            $0.width.equalTo(88)
            $0.verticalEdges.equalToSuperview()
        }
        
        highDiscountButton.snp.makeConstraints {
            $0.leading.equalTo(highPriceButton.snp.trailing).offset(40)
            $0.width.equalTo(88)
            $0.verticalEdges.equalToSuperview()
        }
        
        facilityLabel.snp.makeConstraints {
            $0.leading.equalTo(highDiscountButton.snp.trailing).offset(40)
            $0.trailing.equalTo(scrollView.contentLayoutGuide).inset(38)
            $0.width.equalTo(152)
            $0.centerY.equalToSuperview()
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.height.equalTo(scrollView.frameLayoutGuide)
            $0.width.equalTo(586) // Calculate total content width
        }
    }
}

