//
//  AddCompareViewController.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/17/24.
//

import UIKit
import SnapKit


final class AddCompareViewController: UIViewController {
    
    private var isSelected = false
    
    private let rootView = AddCompareRootView()
    private let dataModel = CompareRoomData.dummyData()
    
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
        return dataModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCompareTableViewCell.className, for: indexPath)
                as? AddCompareTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 108
}

extension AddCompareViewController: UITableViewDelegate {}
