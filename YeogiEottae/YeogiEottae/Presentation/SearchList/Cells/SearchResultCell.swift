//
//  SearchResultCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let hotelImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    let accomodationKindLabel: UILabel = {
        let label = UILabel()
        label.text = "호텔"
        label.font = UIFont.projectFont(name: .l7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray850)
        return label
    }()
    
    let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .h4)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    let transportationAccessibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l2)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    let ratingContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemColor(brightness: .starLight)
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    let starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "starRate"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l4)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray950)
        return label
    }()
    
    let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b6)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = UIColor.grayColor(brightness: .gray850)
        return label
    }()
    
    let heartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "like20")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    let discountRateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = UIColor.brandColor(brightness: .brand)
        return label
    }()
    
    let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    let isCouponAppliedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .h3)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    let discountedPriceCurrencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .h4)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray900)
        return label
    }()
    
    let subTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b7)
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = UIColor.brandColor(brightness: .brand)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        
        self.ratingContainerView.addSubviews(self.starImage, self.ratingLabel)
        
        self.addSubviews(
            self.hotelImageView,
            
            self.accomodationKindLabel,
            self.hotelNameLabel,
            self.transportationAccessibilityLabel,
            self.ratingContainerView,
            self.ratingCountLabel,
            
            self.heartButton,
            
            self.discountRateLabel,
            self.discountPriceLabel,
            self.isCouponAppliedLabel,
            self.discountedPriceLabel,
            self.discountedPriceCurrencyLabel,
            self.subTextLabel
        )
        
    }
    
    private func setConstraints() {
        
        
        
        
    }
        
    
    func configureData(with data: Hotel) {
        
    }
    
}
