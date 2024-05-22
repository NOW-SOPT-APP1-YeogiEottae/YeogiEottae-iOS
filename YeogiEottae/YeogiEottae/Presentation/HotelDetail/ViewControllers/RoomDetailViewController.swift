//
//  RoomDetailViewController.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//
import UIKit

class RoomDetailViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    
    enum Section: Int, CaseIterable {
        case image, details, info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.register(RoomImageViewCell.self, forCellReuseIdentifier: "RoomImageViewCell")
        tableView.register(RoomDetailViewCell.self, forCellReuseIdentifier: "RoomDetailViewCell")
        tableView.register(RoomInfoViewCell.self, forCellReuseIdentifier: "RoomInfoViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        //.never로 설정했는데 왜 이미지가 끝까지 나타나지 않지?
        tableView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension RoomDetailViewController {
    
    //Section의 갯수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    //셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = Section(rawValue: section) else { return 0 }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomImageViewCell", for: indexPath) as! RoomImageViewCell
            cell.backgroundColor = .red
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomDetailViewCell", for: indexPath) as! RoomDetailViewCell
            cell.backgroundColor = .yellow
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomInfoViewCell", for: indexPath) as! RoomInfoViewCell
            cell.backgroundColor = .green
            return cell
            
        }
    }
}

