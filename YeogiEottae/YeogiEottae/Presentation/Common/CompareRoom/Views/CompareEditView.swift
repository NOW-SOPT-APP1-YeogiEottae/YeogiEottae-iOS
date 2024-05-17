//
//  CompareEditView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit


class CompareEditView : UIView {
    
    private let editLabel: UILabel =  {
        let label = UILabel()
        label.text = "수정하기"
        label.textColor = .grayColor(brightness: .gray800)
        label.font = UIFont.projectFont(name: .b3)
        return label
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
        editLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setHierarchy() {
        self.addSubviews(editLabel)
    }
}
