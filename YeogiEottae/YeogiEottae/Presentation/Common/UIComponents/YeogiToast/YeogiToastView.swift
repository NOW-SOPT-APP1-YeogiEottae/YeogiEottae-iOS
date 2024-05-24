//
//  YeogiToastView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/18/24.
//

import UIKit

import SnapKit


final class YeogiToastView: UIView {
    
    private var toastType: ToastType?
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b3)
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.projectFont(name: .b6)
        label.textColor = .grayColor(brightness: .gray400)
        label.text = "찜도 찜할 수 있어요"
        return label
    }()
    
    private let switchButton: UISwitch = {
        let switchButton = UISwitch()
        return switchButton
    }()
    
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .grayColor(brightness: .gray900)
        return view
    }()
    
    private lazy var moveButton: UIButton = {
        let button = UIButton()
        button.setTitle("바로이동", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b3)
        button.setTitleColor(.systemColor(brightness: .toastMove), for: .normal)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("실행취소", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .b3)
        button.setTitleColor(.brandColor(brightness: .brandLight), for: .normal)
        return button
    }()
    
    init(type: ToastType, backgroundColor: UIColor? = .systemColor(brightness: .toast, alpha: 0.8)) {
        super.init(frame: .zero)
        self.toastType = type
        let message: String
        switch type {
        case .soldout:
            messageLabel.font = UIFont.projectFont(name: .l4)
            message = "매진된 숙소 빼고 보기"
        case .deinitLike:
            message = "찜을 해제 했어요"
        case .addHotelLike:
            message = "찜에 추가했어요"
        case .addRoomLike:
            message = "찜에 추가했어요"
        case .addCompare:
            message = "비교하기에 추가했어요"
        case .warnLimitCompare:
            message = "5개까지 추가할 수 있어요"
        }
        self.messageLabel.text = message
        self.backgroundColor = backgroundColor?.withAlphaComponent(0.8)
        
        setHierarchy()
        setStyle()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        self.clipsToBounds = true
    }
    
    private func setHierarchy() {
        self.addSubview(messageLabel)
        switch toastType {
        case .soldout:
            self.addSubview(switchButton)
        case .deinitLike:
            self.addSubview(cancelButton)
        case .addHotelLike:
            self.addSubviews(cancelButton, moveButton, divideView, subTitleLabel)
        case .addRoomLike, .addCompare:
            self.addSubviews(moveButton, divideView, cancelButton)
        case .warnLimitCompare, .none:
            break
        }
    }
    
    private func setConstraints() {
        switch toastType {
        case .addHotelLike:
            messageLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(11)
                $0.leading.equalToSuperview().inset(24)
            }
        default:
            messageLabel.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(24)
            }
        }
        
        switch toastType {
        case .soldout:
            switchButton.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(10)
                $0.height.equalTo(26)
                $0.width.equalTo(44)
                $0.centerY.equalTo(messageLabel)
            }
        case .deinitLike:
            cancelButton.snp.makeConstraints {
                $0.width.equalTo(71)
                $0.height.equalTo(48)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(18)
            }
        case .addHotelLike:
            subTitleLabel.snp.makeConstraints {
                $0.leading.equalTo(messageLabel)
                $0.top.equalTo(messageLabel.snp.bottom).offset(1)
            }
            
            moveButton.snp.makeConstraints {
                $0.width.equalTo(71)
                $0.height.equalTo(48)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(divideView.snp.leading).offset(-4)
            }
            
            divideView.snp.makeConstraints {
                $0.trailing.equalTo(cancelButton.snp.leading).offset(-4)
                $0.width.equalTo(2)
                $0.height.equalTo(24)
                $0.centerY.equalToSuperview()
            }
            
            cancelButton.snp.makeConstraints {
                $0.width.equalTo(71)
                $0.height.equalTo(48)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(18)
            }
        case .addRoomLike, .addCompare:
            moveButton.snp.makeConstraints {
                $0.width.equalTo(71)
                $0.height.equalTo(48)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(divideView.snp.leading).offset(-4)
            }
            
            divideView.snp.makeConstraints {
                $0.trailing.equalTo(cancelButton.snp.leading).offset(-4)
                $0.width.equalTo(2)
                $0.height.equalTo(24)
                $0.centerY.equalToSuperview()
            }
            
            cancelButton.snp.makeConstraints {
                $0.width.equalTo(71)
                $0.height.equalTo(48)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(18)
            }
        case .warnLimitCompare, nil:
            break
        }
    }
}
