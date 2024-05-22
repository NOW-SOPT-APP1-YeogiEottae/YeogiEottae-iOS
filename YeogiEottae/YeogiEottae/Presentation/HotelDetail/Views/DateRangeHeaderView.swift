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
    private let separatorView = UIView()

    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .white
        
        dateRangeLabel.text = "5.15 수 - 5.16 토 1박"
        dateRangeLabel.font = UIFont.systemFont(ofSize: 16)
        dateRangeLabel.textColor = .black
        
        personCountLabel.text = "2명"
        personCountLabel.font = UIFont.systemFont(ofSize: 16)
        personCountLabel.textColor = .black
        
        separatorView.backgroundColor = .lightGray
        
        addSubview(dateRangeLabel)
        addSubview(personCountLabel)
        addSubview(separatorView)
        
        dateRangeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        personCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(24)
        }
    }
}

