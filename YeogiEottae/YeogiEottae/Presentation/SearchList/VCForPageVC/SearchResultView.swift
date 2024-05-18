//
//  SearchListTableView.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/15.
//

import UIKit

typealias TableViewDelegate = UITableViewDataSource & UITableViewDelegate

final class SearchResultView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.register(SearchResultHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchResultHeaderView.reuseIdentifier)
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 44
        tableView.separatorStyle = .none
        tableView.scrollsToTop = true
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
        self.addSubview(self.tableView)
    }
    
    private func setConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
