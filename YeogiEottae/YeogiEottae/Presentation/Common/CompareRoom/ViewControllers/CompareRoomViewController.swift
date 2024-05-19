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
        getComparerListData()
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
    
    private func syncScrollViews(excludedScrollView: UIScrollView) {
        for cell in rootView.tableView.visibleCells {
            if let compareCell = cell as? CompareTableViewCell, 
                compareCell.scrollView != excludedScrollView {
                compareCell.scrollView.contentOffset.x = scrollViewOffsetX
            }
        }
        if rootView.filterView.scrollView != excludedScrollView {
            rootView.filterView.scrollView.contentOffset.x = scrollViewOffsetX
        }
    }
    
    @objc private func addButtonTapped() {

    }
    
    private func getComparerListData() {
        CompareService.shared.getComparerListData(price: "1", review: "1") { [weak self] response in
            switch response {
            case .success(let data):
                if let data = data as? [CompareListResponseDTO] {
                    print(data)
                }
                
            case .requestErr:
                print("요청 오류 입니다")
            case .decodedErr:
                print("디코딩 오류 입니다")
            case .pathErr:
                print("경로 오류 입니다")
            case .serverErr:
                print("서버 오류입니다")
            case .networkFail:
                print("네트워크 오류입니다")
            }
        }
    }
}


extension CompareRoomViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == dataModel.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddButtonCell.className, for: indexPath)
                    as? AddButtonCell else {
                return UITableViewCell()
            }
            cell.addButtonAction = { [weak self] in
                self?.addButtonTapped()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CompareTableViewCell.className, for: indexPath)
                    as? CompareTableViewCell else {
                return UITableViewCell()
            }
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
        syncScrollViews(excludedScrollView: scrollView)
    }
}

extension CompareRoomViewController: CompareFilterViewCellDelegate {
    func compareFilterViewCellDidScroll(_ cell: CompareFilterView, scrollView: UIScrollView) {
        scrollViewOffsetX = scrollView.contentOffset.x
        syncScrollViews(excludedScrollView: scrollView)
    }
}
