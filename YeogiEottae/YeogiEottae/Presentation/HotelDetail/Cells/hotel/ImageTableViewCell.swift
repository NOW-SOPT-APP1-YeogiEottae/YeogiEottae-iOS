//
//  ImageTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit

import SnapKit
import Kingfisher

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
    
    var isFavorite: Bool = false
    var heartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "like20")
        configuration.background.backgroundColor = UIColor.grayColor(brightness: .gray200)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(named: "like20"), for: .normal)
        button.setImage(
            UIImage(named: "like20")?.withTintColor(.brandColor(brightness: .brand), renderingMode: .alwaysOriginal),
            for: .selected
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setButtonsAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.heartButton.convert(self.heartButton.bounds, to: self.contentView).contains(point) {
            return self.heartButton
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    @objc private func heartButtonTapped() {
        print("Heart button tapped")
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
        nameLabel.numberOfLines = 2
        
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
        starImageView.contentMode = .scaleAspectFit
        
        addSubview(heartButton)
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
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(hotelImageView.snp.bottom).offset(41)
            make.right.equalTo(hotelImageView).inset(20)
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
            make.right.equalTo(hotelImageView).inset(89)
        }
        
        positionImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.left.equalTo(hotelImageView).inset(19)
            make.centerY.equalTo(addressLabel)
            make.width.height.equalTo(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.left.equalTo(positionImageView.snp.right).offset(4)
            make.right.equalTo(hotelImageView).inset(19)
        }
        
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(positionImageView.snp.bottom).offset(11)
            make.left.equalTo(hotelImageView).inset(19)
            make.centerY.equalTo(ratingLabel)
            make.width.height.equalTo(20) 
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
    
    private func setButtonsAction() {
        self.heartButton.addTarget(self, action: #selector(heartButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonDidTapped() {
        print(#function)
        self.heartButton.isSelected.toggle()
        self.isFavorite.toggle()
        switch self.isFavorite {
        case true:
            YeogiToast.show(type: .addHotelLike, animationType: .pushFromBottom)
        case false:
            YeogiToast.show(type: .deinitLike, animationType: .pushFromBottom)
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
    
    func configure(with data: GetHotelDetailResponseDTO?, imageURL: String) {
        guard let unwrappedData = data else { return }
        let hotelDetail = unwrappedData.hotelDetail
        
        self.nameLabel.text = hotelDetail.hotelName
        self.addressLabel.text = hotelDetail.location
        self.ratingLabel.text = "\(hotelDetail.reviewRate)" //문자열 보간법(Sting interpolation)
        self.reviewLabel.text = "\(hotelDetail.reviewCount)개 리뷰"
        self.hotelImageView.kf.setImage(with: URL(string: imageURL))
        self.isFavorite = hotelDetail.isLiked
        self.heartButton.isSelected = self.isFavorite
    }
}

