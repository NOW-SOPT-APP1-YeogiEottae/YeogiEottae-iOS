//
//  SearchSegmentCell.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/14.
//

import UIKit

class SearchSegmentCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                self.segmentLabel.font = UIFont.projectFont(name: .b1)
            case false:
                self.segmentLabel.font = UIFont.projectFont(name: .b2)
            }
        }
    }
    
    let segmentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.contentView.addSubview(self.segmentLabel)
    }
    
    private func setConstraints() {
        self.segmentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(19)
        }
        
        //self.contentView.translatesAutoresizingMaskIntoConstraints = false
        //self.contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
    
}
