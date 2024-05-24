//
//  CompareNavigationBarView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit

import SnapKit


final class CompareNavigationBarView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.CompareRoom.navigationTitle
        label.textColor = .black
        label.font = UIFont.projectFont(name: .h3)
        return label
    }()
    
    let arrowButton : UIButton =  {
        let button = UIButton()
        button.setImage(.arrowBack, for: .normal)
        return button
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
        self.addSubviews(titleLabel,arrowButton)
    }
    
    private func setConstraints() {
        arrowButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(arrowButton.snp.trailing).offset(12)
        }
    }
}

