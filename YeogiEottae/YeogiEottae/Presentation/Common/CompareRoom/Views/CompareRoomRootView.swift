//
//  CompareRoomRootView.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import UIKit

import SnapKit


final class CompareRoomRootView: UIView {
    
    var sectionHeaderHeightConstraint: Constraint?
    
    let tableView = UITableView()
    let navigationHeader = CompareNavigationBarView()
    private let sectionHeader = CompareCalendarView()
    let repairView = CompareEditView()
    let filterView = CompareFilterView()
    let emptyDataView = EmptyDataView()
    private lazy var reservationButton = CompareButton(type: .reservation, addAmount: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
        setStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(
            sectionHeader,
            filterView,
            tableView,
            reservationButton,
            emptyDataView
        )
        
        sectionHeader.addSubview(navigationHeader)
        sectionHeader.addSubview(repairView)
    }
    
    private func setConstraints() {
        navigationHeader.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
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
        
        repairView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(42)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(filterView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        reservationButton.snp.makeConstraints {
            $0.width.equalTo(337)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(-50)
        }
        
        emptyDataView.snp.makeConstraints {
            $0.top.equalTo(repairView.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setStyle() {
        self.backgroundColor = .white
        self.tableView.separatorStyle = .none
    }
    
    func showReservationButton() {
        UIView.animate(withDuration: 0.2) {
            self.reservationButton.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(36) 
            }
            self.layoutIfNeeded()
        }
    }
}
