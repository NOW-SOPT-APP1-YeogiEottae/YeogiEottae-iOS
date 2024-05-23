//
//  DatePersonCountView.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit
import SnapKit

class DatePersonCountView: UIView {
    
    let dateLabel = UILabel()
    let personCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        // Styling the view
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        
        // Configure the date label
        dateLabel.text = "5.15 수 - 5.16 토  1박"
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textAlignment = .left
        
        // Configure the person count label
        personCountLabel.text = "2명"
        personCountLabel.font = UIFont.systemFont(ofSize: 14)
        personCountLabel.textAlignment = .right
        
        // Adding subviews
        addSubview(dateLabel)
        addSubview(personCountLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(personCountLabel.snp.left).offset(-8)
        }
        
        personCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
}

