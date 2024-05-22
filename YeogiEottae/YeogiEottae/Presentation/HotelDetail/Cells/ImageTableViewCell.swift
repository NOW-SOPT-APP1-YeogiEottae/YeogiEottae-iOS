//
//  ImageTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit
import SnapKit

class ImageTableViewCell: UITableViewCell {
    
    let hotelImageView = UIImageView()
    let nameLabel = UILabel()
    let moreLabel = UILabel()
    let moreReviewLabel = UILabel()
    let addressLabel = UILabel()
    let ratingLabel = UILabel()
    let reviewLabel = UILabel()
    let positionImageView = UIImageView()
    let starImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        hotelImageView.contentMode = .scaleAspectFill
        hotelImageView.clipsToBounds = true
        addSubview(hotelImageView)
        
        moreLabel.font = UIFont.projectFont(name: .h6)
        moreLabel.textColor = UIColor.secondaryColor(brightness: .secondary600)
        
        moreReviewLabel.font = UIFont.projectFont(name: .h6)
        moreReviewLabel.textColor = UIColor.secondaryColor(brightness: .secondary600)
        
        nameLabel.font = UIFont.projectFont(name: .h1)
        nameLabel.textColor = UIColor.grayColor(brightness: .gray950)
        
        addressLabel.font = UIFont.projectFont(name: .b4)
        addressLabel.textColor = UIColor.grayColor(brightness: .gray900)
        
        ratingLabel.font = UIFont.projectFont(name: .h3)
        ratingLabel.textColor = UIColor.grayColor(brightness: .gray850)
        
        reviewLabel.font = UIFont.projectFont(name: .b4)
        reviewLabel.textColor = UIColor.grayColor(brightness: .gray700)
        
        
        // Configure the position image view
        positionImageView.image = UIImage(named: "position")
        positionImageView.contentMode = .scaleAspectFit
        
        starImageView.image = UIImage(named: "starRateBig")
        positionImageView.contentMode = .scaleAspectFit
        
        addSubview(moreLabel)
        addSubview(moreReviewLabel)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(ratingLabel)
        addSubview(reviewLabel)
        addSubview(positionImageView)
        addSubview(starImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        hotelImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(375)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.right.equalTo(hotelImageView).inset(17)
        }
        
        moreReviewLabel.snp.makeConstraints { make in
            make.top.equalTo(positionImageView.snp.bottom).offset(11)
            make.right.equalTo(hotelImageView).inset(17)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelImageView.snp.bottom).offset(29)
            make.left.equalTo(hotelImageView).inset(19)
        }
        
        positionImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.left.equalTo(hotelImageView).inset(19)
            make.centerY.equalTo(addressLabel)
            make.width.height.equalTo(20) // Adjust size as necessary
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.left.equalTo(positionImageView.snp.right).offset(4) // Maintain a 4px gap
            make.right.equalTo(hotelImageView).inset(19)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(positionImageView.snp.bottom).offset(11)
            make.left.equalTo(hotelImageView).inset(19)
            make.centerY.equalTo(ratingLabel)
            make.width.height.equalTo(20) // Adjust size as necessary
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(11)
            make.left.equalTo(starImageView.snp.right).offset(4)
            make.bottom.equalToSuperview().inset(31)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(11)
            make.left.equalTo(ratingLabel.snp.right).offset(4)
            make.bottom.equalToSuperview().inset(31)
        }
    }
    
    func configure(with name: String, more: String, moreReview: String, address: String, rating: String, review: String) {
        nameLabel.text = name
        moreLabel.text = more
        moreReviewLabel.text = moreReview
        addressLabel.text = address
        ratingLabel.text = rating
        reviewLabel.text = review
        
        hotelImageView.image = UIImage(named: "hotel1")
    }
}

