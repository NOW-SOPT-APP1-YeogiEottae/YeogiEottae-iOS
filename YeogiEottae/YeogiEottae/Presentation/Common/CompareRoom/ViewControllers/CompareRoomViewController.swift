//
//  CompareRoomViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.

import UIKit
import SnapKit


protocol CompareTableViewCellDelegate: AnyObject {
    func compareTableViewCellDidScroll(_ cell: CompareTableViewCell, scrollView: UIScrollView)
    func compareTableViewCellDidTapRadioButton(_ cell: CompareTableViewCell)
}

protocol CompareFilterViewCellDelegate: AnyObject {
    func compareFilterViewCellDidScroll(_ cell: CompareFilterView, scrollView: UIScrollView)
}

final class CompareRoomViewController: UIViewController {
    
    private var scrollViewOffsetX: CGFloat = 0
    private var isHeaderHidden = false
    private var isSelected = false
    private var isEditingMode = false
    private var selectedIndexPath: IndexPath?
    private var radioSelectedStates: [Bool] = []
    
    private let rootView = CompareRoomRootView()
    private var dataModel : [CompareList] = [] {
        didSet {
            radioSelectedStates = Array(repeating: false, count: dataModel.count)
            DispatchQueue.main.async {
                self.rootView.tableView.reloadData()
                self.updateViewVisibility()
            }
            
        }
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getComparerListData(price: "", review: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        setRegister()
        setDelegate()
        setButtonActions()
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
    
    private func setButtonActions() {
        rootView.repairView.editButton.addTarget(self, action: #selector(repairButtonTapped), for: .touchUpInside)
        rootView.emptyDataView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        rootView.filterView.lowPriceButton.addTarget(self, action: #selector(lowPriceButtonTapped), for: .touchUpInside)
        rootView.filterView.highPriceButton.addTarget(self, action: #selector(highPriceButtonTapped), for: .touchUpInside)
        rootView.filterView.highDiscountButton.addTarget(self, action: #selector(highDiscountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func lowPriceButtonTapped() {
        getComparerListData(price: "", review: "")
        self.rootView.tableView.reloadData()
    }
    
    @objc private func highPriceButtonTapped() {
        getComparerListData(price: "", review: "1")
        self.rootView.tableView.reloadData()
    }
    
    @objc private func highDiscountButtonTapped() {
        getComparerListData(price: "1", review: "")
        self.rootView.tableView.reloadData()
    }
    
    @objc private func repairButtonTapped() {
        isEditingMode.toggle()
        rootView.repairView.editButton.setTitle(isEditingMode ? StringLiteral.Compare.editComplete : StringLiteral.Compare.edit, for: .normal)
        rootView.repairView.editButton.setTitleColor(isEditingMode ? UIColor.secondaryColor(brightness: .secondary600) : UIColor.grayColor(brightness: .gray800), for: .normal)
        
        for cell in rootView.tableView.visibleCells {
            if let compareCell = cell as? CompareTableViewCell {
                compareCell.isEditedMode = isEditingMode
            }
        }
    }
    
    @objc private func addButtonTapped() {
        let viewController = AddCompareViewController()
        viewController.delegate = self
        if viewController.presentationController is UISheetPresentationController {
            if let sheet = viewController.sheetPresentationController {
                sheet.prefersGrabberVisible = true
                if #available(iOS 16.0, *) {
                    sheet.detents = [.custom(resolver: { context in
                        return 665
                    })]
                } else {
                    sheet.detents = [.large()]
                }
            }
        }
        viewController.modalPresentationStyle = .formSheet
        self.present(viewController, animated: true)
    }
    
    private func getComparerListData(price: String, review: String) {
        CompareService.shared.getComparerListData(price: price, review: review) { [weak self] response in
            switch response {
            case .success(let data):
                if let data = data as? CompareListResponseDTO {
                    self?.dataModel = data.result
                    DispatchQueue.main.async {
                        self?.rootView.tableView.reloadData()
                    }
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
    
    private func updateViewVisibility() {
        let isEmpty = dataModel.isEmpty
        rootView.tableView.isHidden = isEmpty
        rootView.emptyDataView.isHidden = !isEmpty
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
            let isRadioSelected = radioSelectedStates[indexPath.row]
            cell.bindData(data: dataModel[indexPath.row], isRadioSelected: isRadioSelected, isEditedMode: isEditingMode)
            cell.delegate = self
            cell.scrollView.contentOffset.x = scrollViewOffsetX
            cell.isRadioSelected = (indexPath == selectedIndexPath)
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
    func compareTableViewCellDidTapRadioButton(_ cell: CompareTableViewCell) {
        if isEditingMode {
            if let roomId = cell.roomId {
                let popupViewController = YeogiAlertViewController()
                popupViewController.roomId = roomId
                popupViewController.delegate = self
                popupViewController.modalPresentationStyle = .overFullScreen
                self.present(popupViewController, animated: false)
            }
        } else {
            if selectedIndexPath == nil {
                rootView.showReservationButton()
            }
            if let indexPath = rootView.tableView.indexPath(for: cell) {
                selectedIndexPath = indexPath
                radioSelectedStates[indexPath.row] = !radioSelectedStates[indexPath.row]
                rootView.tableView.reloadData()
            }
            
        }
    }
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

extension CompareRoomViewController: YeogiAlertViewControllerDelegate {
    func didDeleteRoom() {
        getComparerListData(price: "", review: "")
    }
}

extension CompareRoomViewController: AddCompareViewControllerDelegate {
    func didAddRoom() {
        getComparerListData(price: "", review: "")
        YeogiToast.show(type: .addCompare)
    }
}
