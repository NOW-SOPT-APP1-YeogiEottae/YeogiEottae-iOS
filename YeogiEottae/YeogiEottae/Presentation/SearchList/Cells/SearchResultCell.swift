//
//  SearchResultCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

import Kingfisher

class SearchResultCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var accommodationInfo: HotelInfo? = nil
    var accommodationID: Int = 0
    var accommodationImageURL: URL? = nil
    var isFavorite: Bool = false {
        didSet {
            switch self.isFavorite {
            case true:
                //서버에 찜 요청하는 코드
                self.heartButton.isSelected = self.isFavorite
            case false:
                //서버에 찜 해제 요청하는 코드
                self.heartButton.isSelected = self.isFavorite
            }
            
            
            
        }
    }
    
    let accommodationImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    let accommodationKindLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.SearchList.hotel
        label.font = UIFont.projectFont(name: .l7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray850)
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .h4)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    var transportationAccessibilityLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.distance
        label.font = UIFont.projectFont(name: .l2)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    var ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemColor(brightness: .starLight)
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    var starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "starRate"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.SearchList.rating
        label.font = UIFont.projectFont(name: .l4)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray950)
        return label
    }()
    
    var ratingCountLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.SearchList.valuation
        label.font = UIFont.projectFont(name: .b6)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray850)
        return label
    }()
    
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
        label.text = StringLiteral.HotelDetail.coupon
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
    
    var subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "sub text"
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = UIColor.brandColor(brightness: .brand)
        return label
    }()
    
    let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
        self.setButtonsAction()
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
    
    private func setUI() {
        self.selectionStyle = .none
    }
    
    private func configureViewHierarchy() {
        
        self.ratingContainerView.addSubviews(self.starImage, self.ratingLabel)
        
        self.addSubviews(
            self.accommodationImageView,
            
            self.accommodationKindLabel,
            self.nameLabel,
            self.transportationAccessibilityLabel,
            self.ratingContainerView,
            self.ratingCountLabel,
            
            self.heartButton,
            
            self.discountRateLabel,
            self.discountPriceLabel,
            self.isCouponAppliedLabel,
            self.discountedPriceLabel,
            self.discountedPriceCurrencyLabel,
            self.subTextLabel,
            
            self.seperator
        )
        
    }
    
    private func setConstraints() {
        
        self.accommodationImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(19)
            make.width.equalTo(120)
            make.height.equalTo(180)
        }
        
        self.accommodationKindLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationImageView.snp.top)
            make.leading.equalTo(self.accommodationImageView.snp.trailing).offset(10)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationKindLabel.snp.bottom).offset(2)
            make.leading.equalTo(self.accommodationKindLabel.snp.leading)
            make.trailing.equalTo(self.accommodationKindLabel.snp.trailing)
        }
        
        self.transportationAccessibilityLabel.snp.makeConstraints { make in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(2)
            make.leading.equalTo(self.accommodationKindLabel.snp.leading)
            make.trailing.equalTo(self.accommodationKindLabel.snp.trailing)
        }
        
        self.ratingContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.transportationAccessibilityLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.accommodationKindLabel.snp.leading)
        }
        
        self.starImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(3)
        }
        
        self.ratingLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.starImage.snp.trailing)
            make.top.equalToSuperview().inset(4.5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(3.5)
        }
        
        self.ratingCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.ratingContainerView)
            make.leading.equalTo(self.ratingContainerView.snp.trailing).offset(5)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.leading.greaterThanOrEqualTo(self.accommodationKindLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(26)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        self.discountRateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountPriceLabel)
            make.trailing.equalTo(self.discountPriceLabel.snp.leading).offset(-2)
            make.height.equalTo(13)
        }
        
        self.discountPriceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(19)
            make.bottom.equalTo(self.discountedPriceCurrencyLabel.snp.top).offset(-2)
            make.height.equalTo(15)
        }
        
        self.isCouponAppliedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountedPriceLabel)
            make.trailing.equalTo(self.discountedPriceLabel.snp.leading).offset(-4)
        }
        
        self.discountedPriceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.discountedPriceCurrencyLabel)
            make.trailing.equalTo(self.discountedPriceCurrencyLabel.snp.leading)
        }
        
        self.discountedPriceCurrencyLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.discountPriceLabel)
            make.bottom.equalTo(self.subTextLabel.snp.top).offset(-3)
            make.height.equalTo(18)
        }
        
        self.subTextLabel.snp.makeConstraints { make in
            make.trailing.equalTo(self.discountPriceLabel)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(13)
        }
        
        self.seperator.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    private func setButtonsAction() {
        self.heartButton.addTarget(self, action: #selector(heartButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonDidTapped() {
        print(#function, self.accommodationInfo!.hotelName)
        self.isFavorite.toggle()
    }
        
    
    func configureData(with data: Hotel) {
        self.nameLabel.text = data.name
        self.discountedPriceLabel.text = "\(data.price)"
        self.ratingLabel.text = "\(data.rate)"
    }
    
    func configureData(with hotelInfoData: HotelInfo) {
        self.accommodationInfo = hotelInfoData
        
        self.nameLabel.text = hotelInfoData.hotelName
        self.accommodationID = hotelInfoData.hotelID
        self.accommodationImageURL = URL(string: hotelInfoData.imageURL)
        self.accommodationImageView.kf.setImage(with: self.accommodationImageURL)
        self.transportationAccessibilityLabel.text = hotelInfoData.location
        self.discountedPriceLabel.text = "\(hotelInfoData.price.formattedWithSeparator)"
        self.ratingCountLabel.text = "\(hotelInfoData.reviewCount.formattedWithSeparator)개 평가"
        self.ratingLabel.text = "\(hotelInfoData.reviewRate)"
        self.accommodationKindLabel.text = hotelInfoData.type
    }
    
}
