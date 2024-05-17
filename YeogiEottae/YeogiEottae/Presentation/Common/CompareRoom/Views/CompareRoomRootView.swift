//
//  CompareRoomRootView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit
import SnapKit

class CompareRoomRootView: UIView {
    let tableView = UITableView()
    let navigationHeader = CompareNavigationBarView()
    let sectionHeader = CompareCalendarView()
    let repairView = CompareEditView()
    let filterView = CompareFilterView()
    
    var sectionHeaderHeightConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(sectionHeader)
        sectionHeader.addSubview(navigationHeader)
        sectionHeader.addSubview(repairView)
        self.addSubview(filterView)
        self.addSubview(tableView)
        
        navigationHeader.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        sectionHeader.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
            self.sectionHeaderHeightConstraint = $0.height.equalTo(148).constraint
        }
        
        filterView.snp.makeConstraints {
            $0.top.equalTo(sectionHeader.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        repairView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
