//
//  CompareRoomViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.

import UIKit
import SnapKit


protocol CompareTableViewCellDelegate: AnyObject {
    func compareTableViewCellDidScroll(_ cell: CompareTableViewCell, scrollView: UIScrollView)
}

protocol CompareFilterViewCellDelegate: AnyObject {
    func compareFilterViewCellDidScroll(_ cell: CompareFilterView, scrollView: UIScrollView)
}

final class CompareRoomViewController: UIViewController {
    
    private var scrollViewOffsetX: CGFloat = 0
    private var isHeaderHidden = false
    
    private let rootView = CompareRoomRootView()
    private let dataModel = RoomData.dummyData()
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        setDelegate()
    }
    
    private func setRegister() {
        rootView.tableView.register(CompareTableViewCell.self, forCellReuseIdentifier: CompareTableViewCell.className)
        rootView.tableView.register(AddButtonCell.self, forCellReuseIdentifier: AddButtonCell.className)
    }
    
    private func setDelegate() {
        rootView.filterView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
    }
    
    private func syncScrollViews(except excludedScrollView: UIScrollView) {
        for cell in rootView.tableView.visibleCells {
            if let compareCell = cell as? CompareTableViewCell, compareCell.scrollView != excludedScrollView {
                compareCell.scrollView.contentOffset.x = scrollViewOffsetX
            }
        }
        if rootView.filterView.scrollView != excludedScrollView {
            rootView.filterView.scrollView.contentOffset.x = scrollViewOffsetX
        }
    }
    
    @objc private func addButtonTapped() {
        //탭 했을 때 동작 추후 구현
    }
}


extension CompareRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataModel.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddButtonCell.className, for: indexPath) as! AddButtonCell
            cell.addButtonAction = { [weak self] in
                self?.addButtonTapped()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CompareTableViewCell.className, for: indexPath) as! CompareTableViewCell
            cell.bindData(data: dataModel[indexPath.row])
            cell.delegate = self
            cell.scrollView.contentOffset.x = scrollViewOffsetX
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}

extension CompareRoomViewController: UITableViewDelegate {}

extension CompareRoomViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == rootView.tableView {
            let offsetY = scrollView.contentOffset.y
            let newHeight: CGFloat = offsetY > 0 ? 48 : 148
            if isHeaderHidden != (newHeight == 48) {
                isHeaderHidden = newHeight == 48
                UIView.animate(withDuration: 0.3) {
                    self.rootView.sectionHeaderHeightConstraint?.update(offset: newHeight)
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}

extension CompareRoomViewController: CompareTableViewCellDelegate {
    func compareTableViewCellDidScroll(_ cell: CompareTableViewCell, scrollView: UIScrollView) {
        scrollViewOffsetX = scrollView.contentOffset.x
        syncScrollViews(except: scrollView)
    }
}

extension CompareRoomViewController: CompareFilterViewCellDelegate {
    func compareFilterViewCellDidScroll(_ cell: CompareFilterView, scrollView: UIScrollView) {
        scrollViewOffsetX = scrollView.contentOffset.x
        syncScrollViews(except: scrollView)
    }
}
