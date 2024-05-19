//
//  FavoritesCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

import SnapKit

class FavoritesRoomCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var initialGestureLocation: CGPoint = CGPointZero
    
    let panGestureRecognizer: UIPanGestureRecognizer = {
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.maximumNumberOfTouches = 1
        return panGestureRecognizer
    }()
    
    let swipeableView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.backgroundColor = .grayColor(brightness: .gray0)
        return view
    }()
    
    let blueViewToAddFavorites: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryColor(brightness: .secondary600)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    let redViewToDeleteFavorites: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 225/255, green: 65/255, blue: 1/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
        self.setGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.contentView.backgroundColor = .clear
        self.contentView.clipsToBounds = false
        //self.clipsToBounds = true
        //self.layer.cornerRadius = 18
        self.contentView.clipsToBounds = false
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
        
        
        self.swipeableView.addSubviews(self.accommodationInfoContainerView, self.roomInfoContainerView)
        
        self.contentView.addSubviews(self.blueViewToAddFavorites, self.redViewToDeleteFavorites, self.swipeableView)
        
    }
    
    private func setConstraints() {
        
        self.blueViewToAddFavorites.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.redViewToDeleteFavorites.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.swipeableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.accommodationInfoContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        self.accommodationImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
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
        
        self.roomInfoContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.accommodationInfoContainerView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(18)
        }
        
        self.roomImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            /*
             피그마 상으로는 너비가 307로 정해져 있지만, 화면 너비에 맞추기 위해 이미지 너비를 설정하지 않고, 화면 너비 기준으로 셀 너비 설정함.
             */
            //make.width.equalTo(307)
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
    }
    
    private func setGestureRecognizer() {
        self.swipeableView.addGestureRecognizer(self.panGestureRecognizer)
        self.panGestureRecognizer.delegate = self
        self.panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(sender:)))
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        print(#function)
        print("location:", sender.location(in: self.contentView))
        print("velocity:", sender.velocity(in: self.contentView))
        let translatedLocation = sender.translation(in: self.contentView)
        
        if translatedLocation.x > 0 {
            self.swipeableView.frame.origin.x = min(translatedLocation.x, self.bounds.width * 0.55)
        } else if translatedLocation.x < 0 {
            self.swipeableView.frame.origin.x = max(translatedLocation.x, -self.bounds.width * 0.55)
        }
        
        
        
        
        
        switch sender.state {
        case .possible:
            print("파써블!!!")
        case .began:
            print("비긴!!!!")
        case .changed:
            print("changed!!!!")
            
            if self.swipeableView.frame.origin.x > 0 {
                self.blueViewToAddFavorites.isHidden = false
                self.redViewToDeleteFavorites.isHidden = true
            } else if self.swipeableView.frame.origin.x < 0 {
                self.blueViewToAddFavorites.isHidden = true
                self.redViewToDeleteFavorites.isHidden = false
            }
            
        case .ended:
            print("끝!!!!")
            self.setSwipeableViewToInitialLocaion()
        case .cancelled:
            print("cancelled!!!!")
        case .failed:
            print("failed!!!!")
        @unknown default:
            print("default")
        }
        
    }
    
    func setSwipeableViewToInitialLocaion() {
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1)
        animator.addAnimations {
            self.swipeableView.frame = .zero
            self.contentView.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    func configureData(accommodationlName: String, rating: Double, roomName: String, price: Int) {
        self.accommodationNameLabel.text = accommodationlName
        self.ratingLabel.text = "\(rating)"
        self.roomNameLabel.text = roomName
        self.discountedPriceLabel.text = "\(price)"
    }
    
    
}



extension FavoritesRoomCell: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        
        let xVelocity = panGestureRecognizer.velocity(in: self.contentView).x
        
//        if xVelocity > 0 {
//            self.blueViewToAddFavorites.isHidden = false
//            self.redViewToDeleteFavorites.isHidden = true
//        } else if xVelocity < 0 {
//            self.blueViewToAddFavorites.isHidden = true
//            self.redViewToDeleteFavorites.isHidden = false
//        }
        
        let xVelocityAbs = abs(panGestureRecognizer.velocity(in: self.contentView).x)
        let yVelocityAbs = abs(panGestureRecognizer.velocity(in: self.contentView).y)
        let ratio = yVelocityAbs / xVelocityAbs
        //if xVelocity > 30 || xVelocity < -30 {
        if ratio < 1 {
            return true
        } else {
            return false
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
}
