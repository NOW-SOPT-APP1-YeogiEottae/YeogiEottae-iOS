//
//  CompareNavigationBarView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit

class CompareNavigationBarView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "객실 비교하기"
        label.textColor = .black
        label.font = UIFont.projectFont(name: .h3)
        return label
    }()
    
    private let arrowImage : UIImageView =  {
        let imageView = UIImageView()
        imageView.image = .arrowBack
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchy() {
        self.addSubviews(titleLabel,arrowImage)
    }

    func setConstraints() {
        arrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(arrowImage.snp.trailing).offset(12)
        }
    }
}

