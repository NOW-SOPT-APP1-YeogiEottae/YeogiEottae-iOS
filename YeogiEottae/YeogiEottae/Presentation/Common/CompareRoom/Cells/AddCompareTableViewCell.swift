//
//  AddCompareTableViewCell.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit

import SnapKit
import Kingfisher


final class AddCompareTableViewCell : UITableViewCell {
    
    weak var delegate: AddTableViewCellDelegate?
    
    var roomId: Int = 0
    
    var isCheckSelected = false {
        didSet {
            updateCheckButtonImage()
        }
    }
    
    let containerView : UIView = {
        let view = UIView()
        view.makeCornerRound(radius: 10)
        return view
    }()
    
    private let roomImageView : UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let roomLabel : UILabel = {
        let label = UILabel()
        label.textColor = .grayColor(brightness: .gray850)
        label.font = UIFont.projectFont(name: .l3)
        return label
    }()
    
    private let hotelLabel : UILabel = {
        let label = UILabel()
        label.textColor = .grayColor(brightness: .gray950)
        label.font = UIFont.projectFont(name: .h4)
        return label
    }()
    
    private let adressLabel : UILabel = {
        let label = UILabel()
        label.textColor = .grayColor(brightness: .gray850)
        label.font = UIFont.projectFont(name: .l6)
        return label
    }()
    
    private lazy var checkButton : UIButton = {
        let button = UIButton()
        button.setImage(.unCheckMark.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setConstraints()
        configureButton()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(containerView)
        
        containerView.addSubviews(
            roomImageView,
            roomLabel,
            hotelLabel,
            adressLabel,
            checkButton
        )
    }
    
    private func setConstraints() {
        containerView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        roomImageView.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(12)
            $0.width.equalTo(84)
        }
        
        roomLabel.snp.makeConstraints {
            $0.leading.equalTo(roomImageView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(22)
        }
        
        hotelLabel.snp.makeConstraints {
            $0.leading.equalTo(roomLabel)
            $0.top.equalTo(roomLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(checkButton.snp.leading)
        }
        
        adressLabel.snp.makeConstraints {
            $0.leading.equalTo(roomLabel)
            $0.top.equalTo(hotelLabel.snp.bottom).offset(8)
        }
        
        checkButton.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(18)
        }
    }
    
    func bindData(data: GetLikeCompareResult) {
        let url = URL(string: data.imageUrl)
        roomImageView.kf.setImage(with: url)
        roomLabel.text = data.roomName
        hotelLabel.text = data.hotelName
        adressLabel.text = data.location
        roomId = data.roomId
    }
    
    private func configureButton() {
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    private func setStyle() {
        selectionStyle = .none
    }
    
    @objc private func checkButtonTapped() {
        delegate?.addTableViewCellDidTapButton(self)
    }
    
    private func updateCheckButtonImage() {
        if isCheckSelected {
            checkButton.setImage(.checkmark.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
            containerView.makeBorder(width: 1, color: .grayColor(brightness: .gray400))
        } else {
            checkButton.setImage(.unCheckMark.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
            containerView.makeBorder(width: 0, color: .grayColor(brightness: .gray400))
        }
    }
}
