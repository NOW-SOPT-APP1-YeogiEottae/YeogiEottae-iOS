//
//  EmptyDataView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/23/24.
//

import UIKit

import SnapKit


final class EmptyDataView : UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.Compare.empty
        label.font = UIFont.projectFont(name: .h2)
        label.textColor = .grayColor(brightness: .gray700)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.Compare.compareEasily
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.projectFont(name: .b6)
        label.textColor = .grayColor(brightness: .gray800)
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(StringLiteral.Compare.add, for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .h3)
        button.setTitleColor(.secondaryColor(brightness: .secondary600), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(204)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(69)
            $0.height.equalTo(44)
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(titleLabel, subTitleLabel, addButton)
    }
}
