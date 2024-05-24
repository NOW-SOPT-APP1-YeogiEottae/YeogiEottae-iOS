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
        label.text = StringLiteral.HotelDetail.distance
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
        label.text = StringLiteral.HotelDetail.empty
        label.font = UIFont.projectFont(name: .l2)
        label.textColor = .grayColor(brightness: .gray850)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let emptyStatusDetailMessageLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.warn
        label.font = UIFont.projectFont(name: .l6)
        label.textColor = .grayColor(brightness: .gray800)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    let chooseRoomButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.HotelDetail.select, for: .normal)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .l1)
        return button
    }()
    
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
        
        self.contentView.addSubviews(
            self.accommodationInfoContainerView,
            self.statusMessageContainer
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
    }
    
    
    func configureData(accommodationlName: String, rating: Double) {
        self.accommodationNameLabel.text = accommodationlName
        self.ratingLabel.text = "\(rating)"
    }
    
}
