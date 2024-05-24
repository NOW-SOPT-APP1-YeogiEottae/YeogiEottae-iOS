//
//  CompareEditView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit


final class CompareEditView : UIView {
    
    lazy var editButton: UIButton =  {
        let button = UIButton()
        button.setTitle(StringLiteral.CompareRoom.edit, for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray800), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b3)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        editButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(editButton)
    }
}
