//
//  RoomInfoViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit
import SnapKit

class RoomInfoViewCell: UITableViewCell {
    var Label1: UILabel = {
        let label = UILabel()
        label.text = "선택 날짜"
        label.font = UIFont.projectFont(name: .h5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.secondaryColor(brightness: .secondary700)
        return label
    }()
    
    var grayBox1: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.grayColor(brightness: .gray100)
        box.layer.cornerRadius = 6
        return box
    }()
    
    var grayBox2: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.grayColor(brightness: .gray100)
        box.layer.cornerRadius = 6
        return box
    }()
    
    private let checkInTitleLabel = UILabel()
    private let checkInDateLabel = UILabel()
    private let checkOutTitleLabel = UILabel()
    private let checkOutDateLabel = UILabel()
    private let separatorView = UIView()
    
    var Label2: UILabel = {
        let label = UILabel()
        label.text = "기본 정보"
        label.font = UIFont.projectFont(name: .h5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.secondaryColor(brightness: .secondary700)
        return label
    }()
    
    private var basicInfoLabels = [UILabel]()
    
    var Label3: UILabel = {
        let label = UILabel()
        label.text = "편의 시설"
        label.font = UIFont.projectFont(name: .h5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.secondaryColor(brightness: .secondary700)
        return label
    }()
    
    var comfortLabel: UILabel = {
        let label = UILabel()
        label.text = "TV, 쇼파, 티테이블, 사무용책상, 옷장, 에어컨, 냉장고,미니바(유료), 드라이기, 욕실용품, 샤워가운, 슬리퍼"
        label.font = UIFont.projectFont(name: .b5)
        label.textColor = UIColor.grayColor(brightness: .gray700)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    var Label4: UILabel = {
        let label = UILabel()
        label.text = "취소 및 환불 규정"
        label.font = UIFont.projectFont(name: .h5)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = UIColor.secondaryColor(brightness: .secondary700)
        return label
    }()
    
    private var refundInfoLabels = [UILabel]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        // Setup labels
        [checkInTitleLabel, checkOutTitleLabel].forEach { label in
            label.font = UIFont.projectFont(name: .b7)
            label.textColor = UIColor.grayColor(brightness: .gray700)
            label.textAlignment = .left
            label.text = label == checkInTitleLabel ? "체크인" : "체크아웃"
        }
        
        [checkInDateLabel, checkOutDateLabel].forEach { label in
            label.font = UIFont.projectFont(name: .b4)
            label.textColor = UIColor.grayColor(brightness: .gray900)
            label.textAlignment = .left
            label.text = "24.05.02 (목)\n15:00"
            label.numberOfLines = 0
        }
        
        let basicInfos = [
            StringLiteral.BasicInfo.basic1,
            StringLiteral.BasicInfo.basic2,
            StringLiteral.BasicInfo.basic3,
            StringLiteral.BasicInfo.basic4
        ]
        basicInfos.forEach { info in
            let label = UILabel()
            label.font = UIFont.projectFont(name: .b5)
            label.textColor = UIColor.grayColor(brightness: .gray700)
            label.textAlignment = .left
            label.text = info
            label.numberOfLines = 0
            basicInfoLabels.append(label)
            contentView.addSubview(label)
        }
        
        let refundInfos = [
            StringLiteral.RefundPolicy.refund1,
            StringLiteral.RefundPolicy.refund2,
            StringLiteral.RefundPolicy.refund3,
            StringLiteral.RefundPolicy.refund4,
            StringLiteral.RefundPolicy.refund5,
            StringLiteral.RefundPolicy.refund6,
            StringLiteral.RefundPolicy.refund7,
        ]
        var refundLabel: UILabel?
                for (index, info) in refundInfos.enumerated() {
                    let label = UILabel()
                    label.font = UIFont.projectFont(name: index == 3 || index == 4 || index == 5 ? .h4 : .b5)
                    label.textColor = index == 3 ? UIColor.systemColor(brightness: .caution) : UIColor.grayColor(brightness: .gray700)
                    label.textAlignment = .left
                    label.text = info
                    label.numberOfLines = 0
                    refundInfoLabels.append(label)
                    contentView.addSubview(label)

                    if index == refundInfos.count - 1 {
                        refundLabel = label
                    }
                }
        
        contentView.addSubview(grayBox1)
        contentView.addSubview(grayBox2)
        grayBox1.addSubview(checkInTitleLabel)
        grayBox1.addSubview(checkInDateLabel)
        grayBox2.addSubview(checkOutTitleLabel)
        grayBox2.addSubview(checkOutDateLabel)
        contentView.addSubview(Label1)
        contentView.addSubview(Label2)
        contentView.addSubview(Label3)
        contentView.addSubview(comfortLabel)
        contentView.addSubview(Label4)
    }
    
    private func setupConstraints() {
        Label1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(18.5)
        }
        
        grayBox1.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.left.equalToSuperview().inset(18.5)
            make.height.equalTo(95)
            make.width.equalTo(167)
        }
        
        grayBox2.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(47)
            make.right.equalToSuperview().inset(18.5)
            make.height.equalTo(95)
            make.width.equalTo(167)
        }
        
        checkInTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(grayBox1).inset(20)
        }
        
        checkInDateLabel.snp.makeConstraints { make in
            make.top.equalTo(checkInTitleLabel.snp.bottom).offset(6)
            make.left.equalTo(checkInTitleLabel)
        }
        
        checkOutTitleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(grayBox2).inset(20)
        }
        
        checkOutDateLabel.snp.makeConstraints { make in
            make.top.equalTo(checkOutTitleLabel.snp.bottom).offset(6)
            make.left.equalTo(checkOutTitleLabel)
        }
        
        Label2.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(29)
            make.top.equalTo(grayBox1.snp.bottom).offset(22)
        }
        
        var lastLabel: UIView = Label2
        for label in basicInfoLabels {
            label.snp.makeConstraints { make in
                make.top.equalTo(lastLabel.snp.bottom).offset(15)
                make.left.equalToSuperview().inset(29)
            }
            lastLabel = label
        }
        
        Label3.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(29)
            make.top.equalTo(Label2.snp.bottom).offset(150)
        }
        
        comfortLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(29)
            make.top.equalTo(Label3.snp.bottom).offset(15)
        }
        
        Label4.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(29)
            make.top.equalTo(comfortLabel.snp.bottom).offset(18)
        }
        
        var lastRefundLabel: UIView = Label4
               for (index, label) in refundInfoLabels.enumerated() {
                   label.snp.makeConstraints { make in
                       make.top.equalTo(lastRefundLabel.snp.bottom).offset(15)
                       make.left.right.equalToSuperview().inset(29)
                       if index == refundInfoLabels.count - 1 {
                           make.bottom.equalToSuperview().inset(18)
                       }
                   }
                   lastRefundLabel = label
               }
    }
}
