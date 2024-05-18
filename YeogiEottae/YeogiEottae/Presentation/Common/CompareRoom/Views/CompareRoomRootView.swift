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
    private let navigationHeader = CompareNavigationBarView()
    private let sectionHeader = CompareCalendarView()
    private let repairView = CompareEditView()
    let filterView = CompareFilterView()
    private let reservationButton = CompareButton(type: .reservation, addAmount: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(
            sectionHeader,
            filterView,
            tableView,
            reservationButton
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
