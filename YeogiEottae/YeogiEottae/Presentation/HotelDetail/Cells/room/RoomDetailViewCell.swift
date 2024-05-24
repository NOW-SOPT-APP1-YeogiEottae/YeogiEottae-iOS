//
//  RoomDetailViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit
import SnapKit

class RoomDetailViewCell: UITableViewCell {
    private let containerView = UIView()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "숙박"
        label.font = UIFont.projectFont(name: .h3)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray950)
        return label
    }()
    
    var bookingInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "입실 15:00 퇴실 12:00"
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    var discountRateLabel: UILabel = {
        let label = UILabel()
        label.text = "10%"
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = UIColor.brandColor(brightness: .brand)
        return label
    }()
    
    var discountPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(
            string: "550000",
            attributes: [NSAttributedString.Key.strikethroughStyle: 1]
        )
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "156900"
        label.font = UIFont.projectFont(name: .h3)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    var discountedPriceCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = UIFont.projectFont(name: .h4)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    var discountInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "6%+20000원 쿠폰 적용가"
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupContainerView()
    }

    private func setupContainerView() {
        contentView.addSubview(containerView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bookingInfoLabel)
        contentView.addSubview(discountRateLabel)
        contentView.addSubview(discountPriceLabel)
        contentView.addSubview(discountedPriceLabel)
        contentView.addSubview(discountedPriceCurrencyLabel)
        contentView.addSubview(discountInfoLabel)
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true

        containerView.snp.makeConstraints { make in
            make.height.equalTo(95)
            make.left.right.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(12)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.left.equalToSuperview().inset(27)
        }
        
        bookingInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(7)
            make.left.equalToSuperview().inset(27)
        }
        
        discountRateLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(20)
            make.right.equalTo(containerView.snp.right).inset(67)
        }
        
        discountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).inset(20)
            make.right.equalTo(containerView.snp.right).inset(19)
        }
        
        discountedPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(discountRateLabel.snp.bottom).offset(5)
            make.right.equalTo(discountedPriceCurrencyLabel.snp.left)
        }
        
        discountedPriceCurrencyLabel.snp.makeConstraints { make in
            make.top.equalTo(discountRateLabel.snp.bottom).offset(5)
            make.right.equalTo(discountPriceLabel.snp.right)
        }
        
        discountInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(discountedPriceLabel.snp.bottom).offset(5)
            make.right.equalTo(discountPriceLabel.snp.right)
        }
    }
    
    func configure(with roomDetail: RoomDetail) {
        discountedPriceLabel.text = "\(roomDetail.price)"
        bookingInfoLabel.text = "입실 \(roomDetail.startTime) 퇴실 \(roomDetail.endTime)"
    }
}
