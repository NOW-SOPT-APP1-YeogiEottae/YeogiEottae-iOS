//
//  AddCompareViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit
import SnapKit


protocol AddTableViewCellDelegate: AnyObject {
    func addTableViewCellDidTapButton(_ cell: AddCompareTableViewCell)
}

final class AddCompareViewController: UIViewController {
    
    private let rootView = AddCompareRootView()
    private let dataModel = AddRoomData.dummyData()
    private var likeRoomList: [Int] = []
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegister()
        setDelegate()
    }
    
    private func setRegister() {
        rootView.tableView.register(AddCompareTableViewCell.self, forCellReuseIdentifier: AddCompareTableViewCell.className)
    }
    
    private func setDelegate() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
    }
}

extension AddCompareViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCompareTableViewCell.className, for: indexPath)
                as? AddCompareTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.bindData(data: dataModel[indexPath.row])
        return cell
    }
}


extension AddCompareViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

extension AddCompareViewController : AddTableViewCellDelegate {
    func addTableViewCellDidTapButton(_ cell: AddCompareTableViewCell) {
        cell.isCheckSelected.toggle()
        
        if cell.isCheckSelected {
            likeRoomList.append(cell.roomId)
        } else {
            if let index = likeRoomList.firstIndex(of: cell.roomId) {
                likeRoomList.remove(at: index)
            }
        }
        
        rootView.addButton.likeAmount = likeRoomList.count
    }
}
