//
//  YeogiAlertView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/19/24.
//

import UIKit
import SnapKit

final class YeogiAlertView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정말 삭제하시겠어요?"
        label.font = UIFont.projectFont(name: .b4)
        label.textColor = .black
        return label
    }()
    
    lazy var cancelButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray850), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .h4)
        button.makeCornerRound(radius: 8)
        button.backgroundColor = .grayColor(brightness: .gray400)
        return button
    }()
    
    private lazy var deleteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(UIColor.grayColor(brightness: .gray0), for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .h4)
        button.makeCornerRound(radius: 8)
        button.backgroundColor = .secondaryColor(brightness: .secondary600)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(
            titleLabel,
            cancelButton,
            deleteButton
        )
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.top.equalToSuperview().inset(28)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.equalTo(145)
            $0.height.equalTo(46)
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.equalTo(cancelButton.snp.trailing).offset(9)
            $0.centerY.equalTo(cancelButton)
            $0.width.equalTo(145)
            $0.height.equalTo(46)
        }
    }
    
    private func setStyle() {
        self.makeCornerRound(radius: 10)
        self.backgroundColor = .grayColor(brightness: .gray0)
    }
}
