//
//  CompareCalendarView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit

import SnapKit


final class CompareCalendarView: UIView {
    
    private lazy var dateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .grayColor(brightness: .gray200)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let dateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .calendar
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.CompareRoom.calander
        label.textColor = .black
        label.font = UIFont.projectFont(name: .h6)
        return label
    }()
    
    private lazy var headCountButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .grayColor(brightness: .gray200)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let headCountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .person
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let headCountLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.CompareRoom.person
        label.textColor = .black
        label.font = UIFont.projectFont(name: .h6)
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
        dateButton.addSubview(dateImageView)
        dateButton.addSubview(dateLabel)
        
        headCountButton.addSubview(headCountImageView)
        headCountButton.addSubview(headCountLabel)
        
        self.addSubview(dateButton)
        self.addSubview(headCountButton)
    }
    
    private func setConstraints() {
        dateButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(54)
            $0.leading.equalToSuperview().offset(19)
            $0.width.equalTo(251)
            $0.height.equalTo(40)
        }
        
        dateImageView.snp.makeConstraints {
            $0.leading.equalTo(dateButton).offset(12)
            $0.centerY.equalTo(dateButton)
            $0.width.height.equalTo(24)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(dateImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(dateButton)
        }
        
        headCountButton.snp.makeConstraints {
            $0.top.equalTo(dateButton.snp.top)
            $0.leading.equalTo(dateButton.snp.trailing).offset(10)
            $0.height.equalTo(dateButton.snp.height)
            $0.width.equalTo(76)
        }
        
        headCountImageView.snp.makeConstraints {
            $0.leading.equalTo(headCountButton).offset(8)
            $0.centerY.equalTo(headCountButton)
            $0.width.height.equalTo(24)
        }
        
        headCountLabel.snp.makeConstraints {
            $0.leading.equalTo(headCountImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(headCountButton)
        }
    }
}
