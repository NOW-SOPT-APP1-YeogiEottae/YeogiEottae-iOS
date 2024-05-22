//
//  DetailTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let moreLabel = UILabel()
    let paymentMethodImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "imgTosspay"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let paymentLabel: UILabel = {
        let label = UILabel()
        label.text = "토스페이"
        return label
    }()
    
    let detailLabel1 = UILabel()
    let detailLabel2 = UILabel()
    let detailLabel3 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        logoImageView.contentMode = .scaleAspectFit
        contentView.addSubview(logoImageView)
        
        titleLabel.font = UIFont.projectFont(name: .b1)
        titleLabel.textColor = UIColor.grayColor(brightness: .gray900)
        
        moreLabel.font = UIFont.projectFont(name: .h4)
        moreLabel.textColor = UIColor.secondaryColor(brightness: .secondary600)
        
        paymentLabel.font = UIFont.projectFont(name: .h5)
        paymentLabel.textColor = UIColor.grayColor(brightness: .gray950)
        
        [detailLabel1, detailLabel2, detailLabel3].forEach { label in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .gray
            label.numberOfLines = 0
            contentView.addSubview(label)
        }
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreLabel)
        contentView.addSubview(paymentLabel)
        self.contentView.addSubview(self.paymentMethodImageView)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalToSuperview().inset(56)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.right.equalToSuperview().inset(23)
        }
        
        paymentLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(19)
            make.left.equalTo(paymentMethodImageView.snp.right)
        }
        
        paymentMethodImageView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(19)
            make.left.equalToSuperview().inset(22)
        }
        
        detailLabel1.snp.makeConstraints { make in
            make.top.equalTo(paymentLabel.snp.bottom).offset(11)
            make.left.right.equalToSuperview().inset(17)
        }
        
        detailLabel2.snp.makeConstraints { make in
            make.top.equalTo(detailLabel1.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(17)
        }
        
        detailLabel3.snp.makeConstraints { make in
            make.top.equalTo(detailLabel2.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(17)
            make.bottom.equalToSuperview().inset(21)
        }
    }
    
    func configure(logoImage: UIImage?, title: String, more: String, payment: String? = nil, paymentMethodImage: UIImage? = nil, detail1: String, detail2: String, detail3: String) {
        logoImageView.image = logoImage
        titleLabel.text = title
        moreLabel.text = more
        paymentLabel.text = payment
        self.paymentMethodImageView.image = paymentMethodImage
        detailLabel1.text = detail1
        detailLabel2.text = detail2
        detailLabel3.text = detail3
        
        detailLabel1.setFont(forSubstring: "5천원 캐시백", toFont: UIFont.projectFont(name: .h5))
        detailLabel3.setFont(forSubstring: "5천원 캐시백", toFont: UIFont.projectFont(name: .h5))
    }
}
