//
//  DetailTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit
import SnapKit

class DetailTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let titleLabel = UILabel()
    let detailLabel1 = UILabel()
    let detailLabel2 = UILabel()
    let detailLabel3 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .darkGray
        
        [detailLabel1, detailLabel2, detailLabel3].forEach { label in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .gray
            label.numberOfLines = 0
            contentView.addSubview(label)
        }
        
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
        }
        
        detailLabel1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        detailLabel2.snp.makeConstraints { make in
            make.top.equalTo(detailLabel1.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        detailLabel3.snp.makeConstraints { make in
            make.top.equalTo(detailLabel2.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configure(title: String, detail1: String, detail2: String, detail3: String) {
        titleLabel.text = title
        detailLabel1.text = detail1
        detailLabel2.text = detail2
        detailLabel3.text = detail3
    }
}
