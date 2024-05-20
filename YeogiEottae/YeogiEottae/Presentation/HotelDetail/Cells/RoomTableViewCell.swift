//
//  RoomTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit
import SnapKit

class RoomTableViewCell: UITableViewCell {
    static let reuseIdentifier = "RoomTableViewCell"

    let dateLabel = UILabel()
    let peopleCountLabel = UILabel()
    let roomImageView = UIImageView()
    let roomTypeLabel = UILabel()
    let priceLabel = UILabel()
    let bookingInfoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textAlignment = .center
        
        peopleCountLabel.font = UIFont.systemFont(ofSize: 12)
        peopleCountLabel.textAlignment = .center
        
        roomImageView.contentMode = .scaleAspectFill
        roomImageView.clipsToBounds = true
        
        roomTypeLabel.font = UIFont.systemFont(ofSize: 16)
        roomTypeLabel.textColor = .black
        
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        
        bookingInfoLabel.font = UIFont.systemFont(ofSize: 12)
        bookingInfoLabel.textColor = .gray
        
        let topView = UIView()
        contentView.addSubview(topView)
        topView.addSubview(dateLabel)
        topView.addSubview(peopleCountLabel)
        
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomTypeLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(bookingInfoLabel)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        peopleCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        roomImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        roomTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTypeLabel.snp.top)
            make.right.equalToSuperview().inset(16)
        }
        
        bookingInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTypeLabel.snp.bottom).offset(4)
            make.left.equalTo(roomTypeLabel.snp.left)
            make.bottom.equalToSuperview().inset(8)
        }
    }

    func configure(date: String, peopleCount: String, image: UIImage, roomType: String, price: String, bookingInfo: String) {
        dateLabel.text = date
        peopleCountLabel.text = peopleCount
        roomImageView.image = image
        roomTypeLabel.text = roomType
        priceLabel.text = price
        bookingInfoLabel.text = bookingInfo
    }
}
