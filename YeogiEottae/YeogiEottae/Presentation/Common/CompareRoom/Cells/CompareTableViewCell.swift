//
//  CompareTableViewCell.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit

class CompareTableViewCell: UITableViewCell, UIScrollViewDelegate {
    weak var delegate: CompareTableViewCellDelegate?
    
    let infoView = CompareInfoView()
    let stickyView: UIView = {
        let view = UIView()
        return view
    }()
    
    let radioButton: UIButton = {
        let button = UIButton()
        button.setImage(.checkmark, for: .normal)
        return button
    }()
    
    let roomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .gift
        return imageView
    }()
    
    let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .arrowRight
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let roomNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b3)
        label.textColor = .grayColor(brightness: .gray900)
        return label
    }()
    
    let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .l4)
        label.textColor = .grayColor(brightness: .gray600)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        scrollView.delegate = self
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(stickyView)
        contentView.addSubview(scrollView)
        
        stickyView.addSubview(roomImageView)
        stickyView.addSubview(roomNameLabel)
        stickyView.addSubview(radioButton)
        stickyView.addSubview(hotelNameLabel)
        stickyView.addSubview(arrowImageView)
        
        scrollView.addSubview(infoView)
    }
    
    private func setConstraints() {
        stickyView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(137)
        }
        
        radioButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.top.equalToSuperview().inset(9)
            $0.leading.equalToSuperview().inset(12)
        }
        
        roomImageView.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.width.equalTo(100)
            $0.leading.equalToSuperview().inset(14)
            $0.top.equalTo(radioButton.snp.bottom)
        }
        
        roomNameLabel.snp.makeConstraints {
            $0.leading.equalTo(roomImageView.snp.leading)
            $0.top.equalTo(roomImageView.snp.bottom).offset(3)
        }
        
        hotelNameLabel.snp.makeConstraints {
            $0.leading.equalTo(roomImageView)
            $0.top.equalTo(roomNameLabel.snp.bottom).offset(1)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.leading.equalTo(hotelNameLabel.snp.trailing)
            $0.centerY.equalTo(hotelNameLabel)
        }
        
        scrollView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(stickyView.snp.trailing)
        }
        
        infoView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide)
            $0.width.equalTo(586)
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.compareTableViewCellDidScroll(self, scrollView: scrollView)
    }
    
    func dataBind(data: RoomData) {
        roomNameLabel.text = data.roomName
        hotelNameLabel.text = data.hotelName
        roomImageView.image = UIImage(named: data.imageUrl)
    }
}


//func configure(with data: RoomData) {
//    roomNameLabel.text = data.roomName
//    hotelNameLabel.text = data.hotelName
//    roomImageView.image = UIImage(named: data.imageUrl)
//    
//    scrollView.subviews.forEach { $0.removeFromSuperview() }
//    
//    let stackView = UIStackView()
//    stackView.axis = .horizontal
//    stackView.distribution = .fillEqually
//    stackView.spacing = 40
//    scrollView.addSubview(stackView)
//    
//    let priceLabel = createLabel(with: "Price: \(data.price)")
//    let reviewRateLabel = createLabel(with: "Rate: \(data.reviewRate)")
//    let reviewCountLabel = createLabel(with: "Reviews: \(data.reviewCount)")
//    
//    [priceLabel, reviewRateLabel, reviewCountLabel].forEach { stackView.addArrangedSubview($0) }
//    
//    stackView.snp.makeConstraints { make in
//        make.edges.equalToSuperview()
//        make.height.equalTo(135)
//    }
//}
//
//private func createLabel(with text: String) -> UILabel {
//    let label = UILabel()
//    label.text = text
//    label.textAlignment = .center
//    label.font = UIFont.systemFont(ofSize: 12)
//    label.snp.makeConstraints { make in
//        make.width.equalTo(88)
//    }
//    return label
//}
