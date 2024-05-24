//
//  AddButtonCell.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit

import SnapKit


final class AddButtonCell: UITableViewCell {
    
    var addButtonAction: (() -> Void)?
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setImage(.plus, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setHierarchy()
        setConstraints()
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        contentView.addSubview(addButton)
    }
    
    private func setConstraints() {
        addButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(90)
            $0.width.equalTo(137)
        }
    }
    
    private func configureButton() {
        selectionStyle = .none
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        addButtonAction?()
    }
}
