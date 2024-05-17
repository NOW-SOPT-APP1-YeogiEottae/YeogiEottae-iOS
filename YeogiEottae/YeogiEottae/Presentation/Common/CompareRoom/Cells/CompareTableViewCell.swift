//
//  CompareTableViewCell.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit


final class CompareTableViewCell: UITableViewCell {
    
    weak var delegate: CompareTableViewCellDelegate?
    
    var isRadioSelected = false {
        didSet {
            updateRadioButtonImage()
        }
    }
    
    private let infoView = CompareInfoView()
    
    private let stickyView: UIView = {
        let view = UIView()
        view.makeBorder(width: 1, color: .grayColor(brightness: .gray200))
        return view
    }()
    
    private let radioButton: UIButton = {
        let button = UIButton()
        button.setImage(.radioUnchecked, for: .normal)
        return button
    }()
    
    private let roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        return imageView
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .arrowRight
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let roomNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b3)
        label.textColor = .grayColor(brightness: .gray900)
        return label
    }()
    
    private let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l4)
        label.textColor = .grayColor(brightness: .gray600)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        setHierarchy()
        setConstraints()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(stickyView)
        contentView.addSubview(scrollView)
        
        stickyView.addSubview(roomImageView)
        stickyView.addSubview(roomNameLabel)
        stickyView.addSubview(radioButton)
        stickyView.addSubview(hotelNameLabel)
        stickyView.addSubview(arrowImageView)
        
        scrollView.addSubview(infoView)
    }
    
    private func setConstraints() {
        stickyView.snp.makeConstraints { 
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(137)
        }
        
        radioButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(9)
            $0.leading.equalToSuperview().inset(12)
        }
        
        roomImageView.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.width.equalTo(100)
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalTo(radioButton.snp.bottom)
        }
        
        roomNameLabel.snp.makeConstraints {
            $0.leading.equalTo(roomImageView.snp.leading)
            $0.top.equalTo(roomImageView.snp.bottom).offset(3)
        }
        
        hotelNameLabel.snp.makeConstraints {
            $0.leading.equalTo(roomImageView)
            $0.top.equalTo(roomNameLabel.snp.bottom).offset(1)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalTo(hotelNameLabel.snp.trailing)
            $0.centerY.equalTo(hotelNameLabel)
        }
        
        scrollView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalTo(stickyView.snp.trailing)
        }
        
        infoView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide)
            $0.width.equalTo(586)
        }
    }
    
    private func configureCell() {
        selectionStyle = .none
        scrollView.delegate = self
    }
    
    func bindData(data: CompareRoomData) {
        hotelNameLabel.text = data.hotelName
        roomNameLabel.text = data.roomName
        roomImageView.image = .imgBlack
        infoView.priceLabel.text = data.price.formattedWithSeparator + "원"
        let discountPrice = data.price / 10
        infoView.discountPriceLabel.text = discountPrice.formattedWithSeparator
        infoView.discountPriceLabel.attributedText = discountPrice.formattedWithSeparator.strikeThrough()
        infoView.reviewAmountLabel.text = "(\(data.reviewCount.formattedWithSeparator))"
        infoView.ratingLabel.text = "\(data.reviewRate)"
    }
    
    private func configureButton() {
        radioButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)
    }
    
    @objc private func radioButtonTapped() {
        delegate?.compareTableViewCellDidTapRadioButton(self)
    }
    
    private func updateRadioButtonImage() {
        radioButton.setImage(isRadioSelected ? .radioChecked : .radioUnchecked, for: .normal)
    }
}


extension CompareTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.compareTableViewCellDidScroll(self, scrollView: scrollView)
    }
}
