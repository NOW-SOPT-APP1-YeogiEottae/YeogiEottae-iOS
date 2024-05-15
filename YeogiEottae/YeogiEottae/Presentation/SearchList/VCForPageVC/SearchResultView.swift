//
//  SearchListTableView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

protocol TableViewDelegate: UITableViewDataSource, UITableViewDelegate { }

final class SearchResultView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchResultHeaderView.reuseIdentifier)
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        
    }
    
    private func setConstraints() {
        
    }
    
    func setDelegates(to viewController: TableViewDelegate) {
        self.tableView.dataSource = viewController
        self.tableView.delegate = viewController
    }
    
    func setTableViewDataSourceDelegate(to viewController: UITableViewDataSource) {
        self.tableView.dataSource = viewController
    }
    
    func setTableViewDelegateDelegate(to viewController: UITableViewDelegate) {
        self.tableView.delegate = viewController
    }
    
}
