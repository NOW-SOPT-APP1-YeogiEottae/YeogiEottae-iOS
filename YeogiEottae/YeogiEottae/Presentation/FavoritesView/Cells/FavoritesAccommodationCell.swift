//
//  FavoritesRoomCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

import SnapKit

final class FavoritesAccommodationCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let accommodationInfoContainerView = UIView()
    
    let accommodationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    let accommodationNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .h5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    let blackBadgeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imgBlack"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var ratingContainerView = UIView()
    
    var starImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "starRateBig"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont.projectFont(name: .l3)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    var grayDot: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray600)
        view.clipsToBounds = true
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    var transportationAccessibilityLabel: UILabel = {
        let label = UILabel()
        label.text = "건대입구역 도보 3분"
        label.font = UIFont.projectFont(name: .l2)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray850)
        return label
    }()
    
    var arrowRightButton: UIButton = {
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(named: "arrowRight")
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray100)
        return view
    }()
    
    let statusMessageContainer = UIView()
    
    let emptyStatusMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 선택된 방이 없어요"
        label.font = UIFont.projectFont(name: .l2)
        label.textColor = .grayColor(brightness: .gray850)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let emptyStatusDetailMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "방을 선택하면 비교하기 기능을 사용할 수 있어요"
        label.font = UIFont.projectFont(name: .l6)
        label.textColor = .grayColor(brightness: .gray800)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let chooseRoomButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택하기", for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .l1)
        return button
    }()
    
    
    /*
    let roomInfoContainerView = UIView()
    
    let roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray5
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    let roomNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b1)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let roomDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "객실정보"
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray600)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let roomDetailContentLabel: UILabel = {
        let label = UILabel()
        label.text = "기준 2인 최대 2인"
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    let packageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "패키지"
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray600)
        return label
    }()
    
    let packageContentLabel: UILabel = {
        let label = UILabel()
        label.text = "롯데월드 자유이용권 2매"
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
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
            string: "30000",
            attributes: [NSAttributedString.Key.strikethroughStyle: 1]
        )
        label.font = UIFont.projectFont(name: .l5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    var isCouponAppliedLabel: UILabel = {
        let label = UILabel()
        label.text = "쿠폰적용시"
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "90000"
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
     */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.contentView.backgroundColor = .grayColor(brightness: .gray0)
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 18
    }
    
    private func configureViewHierarchy() {
        
        self.ratingContainerView.addSubviews(self.starImageView, self.ratingLabel)
        
        self.accommodationInfoContainerView.addSubviews(
            self.accommodationImageView,
            self.accommodationNameLabel,
            self.blackBadgeImageView,
            self.ratingContainerView,
            self.grayDot,
            self.transportationAccessibilityLabel,
            self.arrowRightButton,
            self.seperator
        )
        
        self.statusMessageContainer.addSubviews(
            self.emptyStatusMessageLabel,
            self.emptyStatusDetailMessageLabel,
            self.chooseRoomButton
        )
        
        /*
        self.roomInfoContainerView.addSubviews(
            self.roomImageView,
            self.roomNameLabel,
            self.roomDetailTitleLabel,
            self.roomDetailContentLabel,
            self.packageTitleLabel,
            self.packageContentLabel,
            
            self.discountRateLabel,
            self.discountPriceLabel,
            self.isCouponAppliedLabel,
            self.discountedPriceLabel,
            self.discountedPriceCurrencyLabel
        )
         */
        
        self.contentView.addSubviews(
            self.accommodationInfoContainerView,
            self.statusMessageContainer
            /*
            self.roomInfoContainerView
             */
        )
        
    }
    
    private func setConstraints() {
        
        self.accommodationInfoContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        self.accommodationImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(6)
            $0.width.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        self.accommodationNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationImageView).offset(2.5)
            make.leading.equalTo(self.accommodationImageView.snp.trailing).offset(8)
            make.height.equalTo(17)
        }
        
        self.blackBadgeImageView.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationImageView).offset(2)
            make.leading.equalTo(self.accommodationNameLabel.snp.trailing).offset(4)
            make.width.equalTo(34.29)
            make.height.equalTo(18)
            make.trailing.lessThanOrEqualTo(self.arrowRightButton.snp.leading).offset(-6.71)
        }
        
        self.ratingContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationNameLabel.snp.bottom).offset(4.5)
            make.leading.equalTo(self.accommodationNameLabel)
            make.height.equalTo(14)
        }
        
        self.starImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
        }
        
        self.ratingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(self.starImageView.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
        }
        
        self.grayDot.snp.makeConstraints { make in
            make.centerY.equalTo(self.ratingContainerView)
            make.leading.equalTo(self.ratingContainerView.snp.trailing).offset(4)
            make.height.width.equalTo(3)
        }
        
        self.transportationAccessibilityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.ratingContainerView)
            make.leading.equalTo(self.grayDot.snp.trailing).offset(4)
            make.height.equalTo(14)
            make.trailing.equalTo(self.blackBadgeImageView)
        }
        
        self.arrowRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        self.seperator.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        self.statusMessageContainer.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationInfoContainerView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(18)
        }
        
        self.emptyStatusMessageLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(self.emptyStatusDetailMessageLabel)
            make.height.equalTo(16)
        }
        
        self.emptyStatusDetailMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(self.emptyStatusMessageLabel.snp.bottom).offset(3)
            make.leading.equalToSuperview()
            make.trailing.equalTo(self.chooseRoomButton.snp.leading).offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(14)
        }
        
        self.chooseRoomButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
        }
        
        /*
        self.roomInfoContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationInfoContainerView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(18)
        }
        
        self.roomImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.width.equalTo(307)
            make.height.equalTo(143)
        }
        
        self.roomNameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roomImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(2)
            make.height.equalTo(19)
        }
        
        self.roomDetailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roomNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.roomNameLabel)
            make.height.equalTo(14)
        }
        
        self.roomDetailContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roomDetailTitleLabel)
            make.leading.equalTo(self.roomDetailTitleLabel.snp.trailing).offset(12)
            make.height.equalTo(14)
            make.trailing.equalTo(self.roomNameLabel)
        }
        
        self.packageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.roomDetailTitleLabel.snp.bottom).offset(6)
            make.leading.equalTo(self.roomNameLabel)
            make.height.equalTo(14)
        }
        
        self.packageContentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.packageTitleLabel)
            make.leading.equalTo(self.roomDetailContentLabel)
            make.height.equalTo(14)
            make.trailing.equalTo(self.roomNameLabel)
        }
        
        self.discountRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountPriceLabel)
            make.trailing.equalTo(self.discountPriceLabel.snp.leading).offset(-2)
            make.height.equalTo(13)
        }
        
        self.discountPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.packageContentLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(2)
            make.height.equalTo(15)
        }
        
        self.isCouponAppliedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountedPriceCurrencyLabel)
            make.trailing.equalTo(self.discountedPriceLabel.snp.leading).offset(-4)
            make.height.equalTo(13)
        }
        
        self.discountedPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(self.discountPriceLabel.snp.bottom).offset(2)
            make.trailing.equalTo(self.discountedPriceCurrencyLabel.snp.leading)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        self.discountedPriceCurrencyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountedPriceLabel)
            make.trailing.equalToSuperview().inset(2)
            make.height.equalTo(18)
        }
         */
    }
    
    
    func configureData(accommodationlName: String, rating: Double) {
        self.accommodationNameLabel.text = accommodationlName
        self.ratingLabel.text = "\(rating)"
        /*
        self.roomNameLabel.text = roomName
        self.discountedPriceLabel.text = "\(price)"
         */
    }
    
}
