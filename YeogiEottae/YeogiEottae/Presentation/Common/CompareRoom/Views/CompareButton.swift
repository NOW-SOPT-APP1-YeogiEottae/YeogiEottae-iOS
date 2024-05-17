//
//  CompareButton.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit
import SnapKit


final class CompareButton: UIButton {
    @frozen
    enum CompareButtonType {
        case reservation
        case add
    }

    var compareButtonType: CompareButtonType = .reservation

    private let buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.projectFont(name: .h4)
        return label
    }()
    
    private let roundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.makeCornerRound(radius: 12)
        return view
    }()
    
    private let countLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor(brightness: .secondary600)
        label.font = UIFont.projectFont(name: .h5)
        return label
    }()

    init(type: CompareButtonType, addAmount: Int = 0) {
        super.init(frame: .zero)
        
        configureButton(addAmount: addAmount, type: type)
        setHierarchy()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setHierarchy() {
        self.addSubview(buttonTitleLabel)
        switch compareButtonType {
        case .reservation:
            break
        case .add:
            self.addSubview(roundView)
            roundView.addSubview(countLabel)
        }
    }

    private func setConstraints() {
        buttonTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        if compareButtonType == .add {
            roundView.snp.makeConstraints {
                $0.size.equalTo(24)
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(buttonTitleLabel.snp.trailing).offset(10)
            }
            
            countLabel.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }

    private func configureButton(addAmount: Int, type: CompareButtonType) {
        self.compareButtonType = type
        self.backgroundColor = .secondaryColor(brightness: .secondary600)
        self.makeCornerRound(radius: 10)
        
        switch compareButtonType {
        case .reservation:
            buttonTitleLabel.text = "예약하기"
        case .add:
            buttonTitleLabel.text = "추가하기"
            countLabel.text = "\(addAmount)"
        }
    }
}
