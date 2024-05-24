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

    private var compareButtonType: CompareButtonType
    var likeAmount : Int = 0 {
        didSet {
            countLabel.text = "\(likeAmount)"
        }
    }

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
    
    let countLabel : UILabel = {
        let label = UILabel()
        label.textColor = .secondaryColor(brightness: .secondary600)
        label.font = UIFont.projectFont(name: .h5)
        return label
    }()

    init(type: CompareButtonType, addAmount: Int) {
        self.compareButtonType = type
        self.likeAmount = addAmount
        super.init(frame: .zero)
        configureButton(addAmount: addAmount)
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

    private func configureButton(addAmount: Int) {
        self.backgroundColor = .secondaryColor(brightness: .secondary600)
        self.makeCornerRound(radius: 10)
        
        switch compareButtonType {
        case .reservation:
            buttonTitleLabel.text = SringLiteral.Compare.reservation
        case .add:
            buttonTitleLabel.text = SringLiteral.Compare.add
            countLabel.text = "\(addAmount)"
        }
    }
}
