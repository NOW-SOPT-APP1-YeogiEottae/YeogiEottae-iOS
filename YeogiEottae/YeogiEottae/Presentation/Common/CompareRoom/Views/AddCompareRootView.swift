//
//  AddCompareRootView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit
import SnapKit


final class AddCompareRootView: UIView {
    
    let tableView = UITableView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.Compare.like
        label.textColor = .black
        label.font = UIFont.projectFont(name: .h3)
        return label
    }()
    lazy var addButton = CompareButton(type: .add, addAmount: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(tableView, addButton, titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.top.equalToSuperview().inset(30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview()
        }
        
        addButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(337)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(36)
        }
    }
    
    private func setStyle() {
        self.backgroundColor = .white
        self.tableView.separatorStyle = .none
    }
}
