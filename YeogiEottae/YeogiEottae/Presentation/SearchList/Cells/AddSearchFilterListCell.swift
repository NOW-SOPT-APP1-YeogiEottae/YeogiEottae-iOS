//
//  AddSearchFilterListCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit

import SnapKit

protocol AddListCellProtocol: AnyObject {
    
    func buttonDidTapped()
    
}

class AddSearchFilterListCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let plusImageButton: UIButton = {
        
        let configuration: UIButton.Configuration = {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(systemName: "plus.circle.fill")
            return configuration
        }()
        
        let button = UIButton(configuration: configuration)
        button.tintColor = .grayColor(brightness: .gray300)
        return button
    }()
    
    weak var delegate: AddListCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setConstraints()
        self.setButtonsTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        self.contentView.addSubview(self.plusImageButton)
    }
    
    private func setConstraints() {
        self.plusImageButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.width.equalTo(50)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setButtonsTarget() {
        self.plusImageButton.addTarget(self, action: #selector(plustImageButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func plustImageButtonDidTapped() {
        self.delegate?.buttonDidTapped()
    }
    
}
