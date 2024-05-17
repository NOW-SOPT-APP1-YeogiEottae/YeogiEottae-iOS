import UIKit
import SnapKit

class CompareInfoView: UIView {
    
    private let discountPercentLabel: UILabel = {
        let label = UILabel()
        label.text = "10%"
        label.font = UIFont.projectFont(name: .b7)
        label.textColor = .brandColor(brightness: .Brand)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "400,000원"
        label.font = UIFont.projectFont(name: .b1)
        label.textColor = .grayColor(brightness: .gray900)
        return label
    }()
    
    private let discountPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "30,000"
        label.font = UIFont.projectFont(name: .l5)
        label.textColor = .grayColor(brightness: .gray700)
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starRate
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.1"
        label.font = UIFont.projectFont(name: .b1)
        label.textColor = .grayColor(brightness: .gray900)
        return label
    }()
    
    private let reviewAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "(1,466)"
        label.font = UIFont.projectFont(name: .b4)
        label.textColor = .grayColor(brightness: .gray850)
        return label
    }()
    
    private let firstComeLabel: UILabel = {
        let label = UILabel()
        label.text = "선착순"
        label.font = UIFont.projectFont(name: .l4)
        label.textColor = .grayColor(brightness: .gray800)
        return label
    }()
    
    private let discountAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "-5000원"
        label.font = UIFont.projectFont(name: .b1)
        label.textColor = .grayColor(brightness: .gray900)
        return label
    }()
    
    private let facilityLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "자쿠지 무료 이용\n수영장\n조식 제공", lineHeight: 20)
        label.numberOfLines = 3
        label.textAlignment = .right
        label.font = UIFont.projectFont(name: .l4)
        label.textColor = .grayColor(brightness: .gray850)
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "더보기"
        label.font = UIFont.projectFont(name: .l6)
        label.textColor = .secondaryColor(brightness: .secondary600)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(
            discountPercentLabel,
            discountPriceLabel,
            priceLabel,
            starImageView,
            ratingLabel,
            reviewAmountLabel,
            firstComeLabel,
            discountAmountLabel,
            facilityLabel,
            moreLabel
        )
    }
    
    private func setConstraints() {
        discountPercentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(35)
            $0.top.equalToSuperview().inset(51)
        }
        
        discountPriceLabel.snp.makeConstraints {
            $0.centerY.equalTo(discountPercentLabel)
            $0.leading.equalTo(discountPercentLabel.snp.trailing).offset(2)
        }
        
        priceLabel.snp.makeConstraints {
            $0.trailing.equalTo(discountPriceLabel)
            $0.top.equalTo(discountPriceLabel.snp.bottom)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(61)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(41)
            $0.size.equalTo(13)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(3)
        }
        
        reviewAmountLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView.snp.centerY)
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(3)
        }
        
        firstComeLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewAmountLabel.snp.trailing).offset(97)
            $0.top.equalToSuperview().inset(50)
        }
        
        discountAmountLabel.snp.makeConstraints {
            $0.trailing.equalTo(firstComeLabel)
            $0.top.equalTo(firstComeLabel.snp.bottom).offset(2)
        }
        
        facilityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.trailing.equalToSuperview().inset(38)
        }
        
        moreLabel.snp.makeConstraints {
            $0.trailing.equalTo(facilityLabel)
            $0.top.equalTo(facilityLabel.snp.bottom).offset(12)
        }
    }
}
