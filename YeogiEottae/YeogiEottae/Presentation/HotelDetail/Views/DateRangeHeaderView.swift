//
//  DateRangeHeaderView.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//
import UIKit

import SnapKit

class DateRangeHeaderView: UIView {
    
    private let dateRangeLabel = UILabel()
    private let personCountLabel = UILabel()
    private let layerView = UIView()
    private let separatorView = UIView()
    private let calView = UIImageView()
    private let personView = UIImageView()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
//        layerView.backgroundColor = UIColor.grayColor(brightness: .gray0)
        layerView.layer.borderWidth = 1.0
        layerView.layer.borderColor = UIColor.grayColor(brightness: .gray500).cgColor
        layerView.layer.cornerRadius = 10
        
        dateRangeLabel.text = StringLiteral.HotelDetail.dateRange
        dateRangeLabel.font = UIFont.projectFont(name: .h4)
        dateRangeLabel.textColor = UIColor.secondaryColor(brightness: .secondary500)
        
        personCountLabel.text = StringLiteral.CompareRoom.person
        personCountLabel.font = UIFont.projectFont(name: .h4)
        personCountLabel.textColor = UIColor.secondaryColor(brightness: .secondary500)
        
        separatorView.backgroundColor = UIColor.grayColor(brightness: .gray500)
        
        calView.image = UIImage(named: "blueCal")
        personView.image = UIImage(named: "bluePerson")
        
        addSubview(layerView)
        addSubview(dateRangeLabel)
        addSubview(personCountLabel)
        addSubview(separatorView)
        addSubview(calView)
        addSubview(personView)
        
        layerView.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(46)
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.greaterThanOrEqualToSuperview()
        }
        
        
        dateRangeLabel.snp.makeConstraints { make in
            make.left.equalTo(calView.snp.right).offset(6)
            make.centerY.equalTo(layerView)
        }
        
        personCountLabel.snp.makeConstraints { make in
            make.left.equalTo(personView.snp.right).offset(6)
            make.centerY.equalTo(layerView)
        }
        
        separatorView.snp.makeConstraints { make in
            make.centerY.equalTo(layerView)
            make.height.equalTo(20)
            make.width.equalTo(1)
        }
        
        calView.snp.makeConstraints { make in
            make.left.equalTo(layerView).inset(32)
            make.centerY.equalTo(layerView)
        }
        
        personView.snp.makeConstraints { make in
            make.right.equalTo(layerView).inset(62)
            make.centerY.equalTo(layerView)
        }
    }
}

