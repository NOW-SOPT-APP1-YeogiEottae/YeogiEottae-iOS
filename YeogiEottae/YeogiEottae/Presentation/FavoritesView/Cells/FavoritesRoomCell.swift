//
//  FavoritesCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/18.
//

import UIKit

import SnapKit
import Moya
import Kingfisher


class FavoritesRoomCell: UICollectionViewCell, FavoriteCellProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let feedbackGenerator = UINotificationFeedbackGenerator()
    let compareProvider = MoyaProvider<CompareTargetType>(plugins: [MoyaLoggingPlugin()])
    let favoriteProvider = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    let tapGestureRecognizerForAccommodationInfo = UITapGestureRecognizer()
    let tapGestureRecognizerForRoomInfo = UITapGestureRecognizer()
    
    var delegate: SwipeCellDelegate?
    var accommodationID: Int = 0
    var roomID: Int = 0
    var isBlueCircleFilled: Bool = false
    var isRedCircleFilled: Bool = false
    
    
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
    
    /*
     bludView UI Components
     */
    
    let blueViewLabel: UILabel = {
        let label = UILabel()
        label.text = "비교에\n추가"
        label.font = UIFont.projectFont(name: .b3)
        label.textColor = .grayColor(brightness: .gray0)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let circleViewForAddToCompareInteraction: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    var blueCirclePathLayer = CAShapeLayer()
    
    let addIconImageViewForBlueView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "swipeAddIcon")?.withTintColor(.grayColor(brightness: .gray0).withAlphaComponent(1)))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let blueViewToAddCompare: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryColor(brightness: .secondary600)
        view.clipsToBounds = true
        view.layer.cornerRadius = 19
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    /*
     blueView UIComponents 끝
     */
    
    /*
     redView UI Components
     */
    
    let redViewLabel: UILabel = {
        let label = UILabel()
        label.text = "찜에서\n삭제"
        label.font = UIFont.projectFont(name: .b3)
        label.textColor = .grayColor(brightness: .gray0)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    let circleViewForRemoveFromFavoritesInteraction: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    var redCirclePathLayer = CAShapeLayer()
    
    let deleteIconImageViewForRedView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "swipeDeleteIcon")?.withTintColor(.grayColor(brightness: .gray0)))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let redViewToDeleteFromCompare: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 225/255, green: 65/255, blue: 1/255, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 19
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    /*
     redView UI Components 끝
     */
    
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
        imageView.contentMode = .scaleAspectFill
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
        label.text = StringLiteral.HotelDetail.roomPerson
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray700)
        return label
    }()
    
    let packageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.package
        label.font = UIFont.pretendardFont(ofSize: 12, weight: 500)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.grayColor(brightness: .gray600)
        return label
    }()
    
    let packageContentLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.amusementpark
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
            string: 30000.formattedWithSeparator,
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
        self.setGestureRecognizers()
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
        
        self.circleViewForAddToCompareInteraction.addSubview(self.addIconImageViewForBlueView)
        self.circleViewForRemoveFromFavoritesInteraction.addSubview(self.deleteIconImageViewForRedView)
        
        self.blueViewToAddCompare.addSubviews(self.blueViewLabel, self.circleViewForAddToCompareInteraction)
        self.redViewToDeleteFromCompare.addSubviews(self.redViewLabel, self.circleViewForRemoveFromFavoritesInteraction)
        
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
        
        self.contentView.addSubviews(self.blueViewToAddCompare, self.redViewToDeleteFromCompare, self.swipeableView)
        
    }
    
    private func setConstraints() {
        
        self.blueViewToAddCompare.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.blueViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(182)
            make.leading.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(157)
        }
        
        self.circleViewForAddToCompareInteraction.snp.makeConstraints { make in
            make.centerY.equalTo(self.blueViewLabel)
            make.leading.equalTo(self.blueViewLabel.snp.trailing).offset(30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.addIconImageViewForBlueView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(23)
        }
        
        self.redViewToDeleteFromCompare.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.redViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(176)
            make.trailing.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(163)
        }
        
        self.circleViewForRemoveFromFavoritesInteraction.snp.makeConstraints { make in
            make.centerY.equalTo(self.redViewLabel)
            make.trailing.equalTo(self.redViewLabel.snp.leading).offset(-30)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.deleteIconImageViewForRedView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(18)
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
    
    func setGestureRecognizers() {
        self.accommodationInfoContainerView.addGestureRecognizer(self.tapGestureRecognizerForAccommodationInfo)
        self.roomInfoContainerView.addGestureRecognizer(self.tapGestureRecognizerForRoomInfo)
        self.tapGestureRecognizerForAccommodationInfo.addTarget(self, action: #selector(handleTapGestureRecognizer(sender:)))
        self.tapGestureRecognizerForRoomInfo.addTarget(self, action: #selector(handleTapGestureRecognizer(sender:)))
        
        self.swipeableView.addGestureRecognizer(self.panGestureRecognizer)
        self.panGestureRecognizer.delegate = self
        self.panGestureRecognizer.addTarget(self, action: #selector(handlePanGesture(sender:)))
    }
    
    @objc private func handleTapGestureRecognizer(sender: UITapGestureRecognizer) {
        switch sender {
        case self.tapGestureRecognizerForAccommodationInfo:
            self.delegate?.accommodationInfoDidTapped(id: self.accommodationID)
            
        case self.tapGestureRecognizerForRoomInfo:
            self.delegate?.roomInfoDidTapped(id: self.roomID)
        default:
            return
        }
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .possible:
            return
            
        case .began:
            return
            
        case .changed:
            if self.swipeableView.frame.origin.x > 0 {
                self.blueViewToAddCompare.isHidden = false
                self.redViewToDeleteFromCompare.isHidden = true
            } else if self.swipeableView.frame.origin.x < 0 {
                self.blueViewToAddCompare.isHidden = true
                self.redViewToDeleteFromCompare.isHidden = false
            }
            
            let translatedLocation = sender.translation(in: self.contentView)
            
            let circleScaleProportion = 1 + 0.3 * (abs(self.swipeableView.frame.origin.x) / (self.bounds.width * 0.55))
            let addIconScaleProportion = 1 + 0.5 * (abs(self.swipeableView.frame.origin.x) / (self.bounds.width * 0.55))
            
            if translatedLocation.x > 0 {
                self.swipeableView.frame.origin.x = min(translatedLocation.x, self.bounds.width * 0.55)
                self.drawCircleAtBlueView(circlePercentage: (self.swipeableView.frame.origin.x) / (self.bounds.width * 0.55))
                self.circleViewForAddToCompareInteraction.transform = CGAffineTransform(scaleX: circleScaleProportion, y: circleScaleProportion)
                self.addIconImageViewForBlueView.transform = CGAffineTransform(scaleX: addIconScaleProportion, y: addIconScaleProportion)
            } else if translatedLocation.x < 0 {
                self.swipeableView.frame.origin.x = max(translatedLocation.x, -self.bounds.width * 0.55)
                self.drawCircleAtRedView(circlePercentage: (self.swipeableView.frame.origin.x) / (self.bounds.width * 0.55))
                self.circleViewForRemoveFromFavoritesInteraction.transform = CGAffineTransform(scaleX: circleScaleProportion, y: circleScaleProportion)
                self.deleteIconImageViewForRedView.transform = CGAffineTransform(scaleX: addIconScaleProportion, y: addIconScaleProportion)
            }
            
            /*
             셀 너비의 55%이상 끌어왔을 때 원 내부를 흰색으로 채우려고 헀는데, 어떤 이유에서인지 기기에서는 동작하지만 시뮬레이터에서는 동작하지 않았다!
             그래서 우선 아래 코드에서 0.55 대신 0.54로 표현하였음.
             */
            if self.swipeableView.frame.origin.x >= self.bounds.width * 0.54 {
                if !self.isBlueCircleFilled {
                    self.fillBlueCircle() {
                        self.panGestureRecognizer.state = .ended
                    }
                }
                
            } else if self.swipeableView.frame.origin.x < -self.bounds.width * 0.54 {
                if !self.isRedCircleFilled {
                    self.fillRedCircle() {
                        self.panGestureRecognizer.state = .ended
                    }
                }
            }
            
        case .ended:
            self.setSwipeableViewToInitialLocaion()
            
        case .cancelled:
            return
            
        case .failed:
            return
            
        @unknown default:
            return
            
        }
    }
    
    private func setSwipeableViewToInitialLocaion() {
        let animator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1)
        animator.addAnimations {
            self.swipeableView.frame = .zero
            self.circleViewForAddToCompareInteraction.transform = CGAffineTransform.identity
            self.circleViewForRemoveFromFavoritesInteraction.transform = CGAffineTransform.identity
            self.contentView.layoutIfNeeded()
        }
        
        animator.addCompletion { position in
            self.emptyBlueCircle()
            self.emptyRedCircle()
        }
        animator.startAnimation()
    }
    
    /// 원에 해당하는 UIBezierPath를 layer로 추가해주는 함수
    /// - Parameters:
    ///   - circlePercentage: 원이 그려질 비율 %를 100으로 나눈 값. 0.0 ~ 1.0
    private func drawCircleAtBlueView(circlePercentage: CGFloat) {
        self.blueCirclePathLayer.removeFromSuperlayer()
        
        let path: UIBezierPath = self.getPath(percentage: circlePercentage)
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = path.cgPath
        shape.strokeColor = UIColor.grayColor(brightness: .gray0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        self.blueCirclePathLayer = shape
        self.circleViewForAddToCompareInteraction.layer.addSublayer(self.blueCirclePathLayer)
    }
    
    private func drawCircleAtRedView(circlePercentage: CGFloat) {
        self.redCirclePathLayer.removeFromSuperlayer()
        
        let path: UIBezierPath = self.getPath(percentage: circlePercentage, clockwise: false)
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        shape.path = path.cgPath
        shape.strokeColor = UIColor.grayColor(brightness: .gray0).cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        self.redCirclePathLayer = shape
        self.circleViewForRemoveFromFavoritesInteraction.layer.addSublayer(self.redCirclePathLayer)
    }
        
    /// 특정 각도만큼의 호에 해당하는 UIBezierPath를 반환하는 함수
    /// - Parameter percentage: 원이 몇 % 그려졌는지를 입력. %를 100으로 나눈 값(0.0 ~ 1.0)을 입력.
    /// - Returns: 그려진 호에 해당하는 UIBezierPath
    private func getPath(percentage: CGFloat, clockwise: Bool = true) -> UIBezierPath {
        let path: UIBezierPath = UIBezierPath()
        let radius = self.circleViewForAddToCompareInteraction.bounds.width / 2
        //let radius: CGFloat = 50
        
        path.move(to: CGPoint(x: radius, y: 0))
        path.addArc(withCenter: CGPoint(x: radius, y: radius), radius: radius, startAngle: -.pi * 0.5, endAngle: -(.pi * 0.5) + (2 * .pi * percentage), clockwise: clockwise)
        
        return path
    }
        
    /// 파란색 원을 채우는 함수. 애니메이션을 실행시킴. (비동기)
    /// - Parameter completion: 애니메이션이 끝나고 호출될 함수
    private func fillBlueCircle(completion: (() -> Void)? = nil) {
        self.feedbackGenerator.notificationOccurred(.success)
        self.isBlueCircleFilled = true
        self.addToCompare(roomID: self.roomID) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    YeogiToast.show(type: .addCompare, animationType: .pushFromBottom)
                case 400:
                    YeogiToast.show(type: .warnLimitCompare, animationType: .pushFromBottom)
                default:
                    return
                }
                
            case .failure(let moyaError):
                fatalError(moyaError.localizedDescription)
            }
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1)
        animator.addAnimations {
            self.circleViewForAddToCompareInteraction.backgroundColor = .grayColor(brightness: .gray0)
            self.addIconImageViewForBlueView.image = UIImage(named: "swipeAddIcon")?.withTintColor(
                UIColor.secondaryColor(brightness: .secondary600),
                renderingMode: .alwaysOriginal
            )
            self.layoutIfNeeded()
        }
        
        animator.addCompletion { position in completion?() }
        animator.startAnimation()
    }
    
    /// 파란색 원을 비우는 함수. 애니메이션이 아님.
    private func emptyBlueCircle() {
        self.isBlueCircleFilled = false
        self.circleViewForAddToCompareInteraction.backgroundColor = .clear
        self.addIconImageViewForBlueView.image = UIImage(named: "swipeAddIcon")?.withTintColor(
            UIColor.grayColor(brightness: .gray0),
            renderingMode: .alwaysOriginal
        )
    }
    
    /// 빨간색 원을 채우는 함수. 애니메이션을 실행시킴. (비동기)
    /// - Parameter completion: 애니메이션이 끝나고 호출될 함수
    private func fillRedCircle(completion: (() -> Void)? = nil) {
        self.feedbackGenerator.notificationOccurred(.success)
        self.isRedCircleFilled = true
        self.removeFromFavorites(roomId: self.roomID) { result in
            switch result {
            case .success:
                YeogiToast.show(type: .deinitLike, animationType: .pushFromBottom)
            case .failure(let moyaError):
                fatalError(moyaError.localizedDescription)
            }
            
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1)
        animator.addAnimations {
            self.circleViewForRemoveFromFavoritesInteraction.backgroundColor = .grayColor(brightness: .gray0)
            self.deleteIconImageViewForRedView.image = UIImage(named: "swipeDeleteIcon")?.withTintColor(
                UIColor.init(red: 225/255, green: 65/255, blue: 1/255, alpha: 1),
                renderingMode: .alwaysOriginal
            )
            self.layoutIfNeeded()
        }
        
        animator.addCompletion { position in completion?() }
        animator.startAnimation()
    }
    
    /// 빨간색 원을 비우는 함수. 애니메이션이 아님.
    private func emptyRedCircle() {
        self.isRedCircleFilled = false
        self.circleViewForRemoveFromFavoritesInteraction.backgroundColor = .clear
        self.deleteIconImageViewForRedView.image = UIImage(named: "swipeDeleteIcon")?.withTintColor(
            UIColor.grayColor(brightness: .gray0),
            renderingMode: .alwaysOriginal
        )
    }
    
    
    func configureData(accommodationID: Int, roomID: Int, accommodationlName: String, rating: Double, roomName: String, priceInString: String, imageURL: String) {
        self.accommodationID = accommodationID
        self.roomID = roomID
        self.accommodationNameLabel.text = accommodationlName
        self.ratingLabel.text = "\(rating)"
        self.roomNameLabel.text = roomName
        self.discountedPriceLabel.text = priceInString
        self.roomImageView.kf.setImage(with: URL(string: imageURL))
    }
    
    
    private func addToCompare(roomID: Int, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        
        self.compareProvider.request(.postLikeCompareDatarequest(request: PostLikeCompareRequestDTO(roomId: [roomID]))) { result in
            completion(result)
        }
//        self.compareProvider.request(.postLikeCompareDatarequest(request: PostLikeCompareRequestDTO(roomId: [roomID]))) { result in
//            switch result {
//            case .success(let response):
//                let data = response.data
//                guard let decodedData = try? JSONDecoder().decode(PostLikeCompareResponseDTO.self, from: data) else { return }
//                print(decodedData.message)
//                self.delegate?.updateCompareListCount()
//                completion()
//                
//            case .failure(let moyaError):
//                fatalError(moyaError.localizedDescription)
//                
//            }
//        }
    }
    
    private func removeFromFavorites(roomId: Int, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        
        self.favoriteProvider.request(.removeFromFavorites(isRoom: true, id: roomId)) { result in
            completion(result)
            
//            switch result {
//            case .success(_):
//                self.delegate?.deleteItem(self)
//                self.delegate?.updateCompareListCount()
//                completion()
//                
//            case .failure(let moyaError):
//                fatalError(moyaError.localizedDescription)
//            }
        }
    }
    
}



extension FavoritesRoomCell: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer else { return false }
        
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
