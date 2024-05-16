//
//  SearchFilterListCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit
import SnapKit

class SearchFilterListCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                self.labelBackgroundView.backgroundColor = .grayColor(brightness: .gray400)
                self.filterNameLabel.font = UIFont.projectFont(name: .h6)
                self.filterNameLabel.textColor = .grayColor(brightness: .gray900)
            case false:
                self.labelBackgroundView.backgroundColor = .clear
                self.filterNameLabel.font = UIFont.pretendardFont(ofSize: 13, weight: .medium)
                self.filterNameLabel.textColor = .grayColor(brightness: .gray800)
            }
        }
    }
    
    
    let labelBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendardFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = UIColor.grayColor(brightness: .gray800)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.filterNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func configureViewHierarchy() {
        self.contentView.addSubview(self.labelBackgroundView)
        self.labelBackgroundView.addSubview(self.filterNameLabel)
    }
    
    private func setConstraints() {
        self.labelBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
        
        self.filterNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(2)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureData(with data: SearchFilter) {
        self.filterNameLabel.text = data.rawValue
    }
    
}
