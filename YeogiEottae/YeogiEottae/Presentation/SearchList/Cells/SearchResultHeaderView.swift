//
//  SearchResultHeaderView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

class SearchResultHeaderView: UITableViewHeaderFooterView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let orderCriteriaLabel: UILabel = {
        let label = UILabel()
        label.text = "여기어때 추천순"
        label.textAlignment = .left
        label.font = UIFont.pretendardFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let setCriteriaButton: UIButton = {
        
        let transformer = UIConfigurationTextAttributesTransformer.init { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = UIColor.grayColor(brightness: .gray900)
            outgoing.font = UIFont.projectFont(name: .l4)
            return outgoing
        }
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "order")
        configuration.imagePadding = 0
        configuration.titleTextAttributesTransformer = transformer
        configuration.baseForegroundColor = UIColor.grayColor(brightness: .gray900)
        
        let button = UIButton(configuration: configuration)
        button.setTitle("정렬", for: .normal)
        button.titleLabel?.font = UIFont.projectFont(name: .l4)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViewHierarchy() {
        self.contentView.addSubviews(self.orderCriteriaLabel, self.setCriteriaButton)
        
    }
    
    private func setConstraints() {
        
        self.orderCriteriaLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(19)
        }
        
        self.setCriteriaButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }
        
        
    }
    
}
