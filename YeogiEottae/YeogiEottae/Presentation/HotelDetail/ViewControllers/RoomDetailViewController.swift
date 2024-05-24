//
//  RoomDetailViewController.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//
import UIKit

class RoomDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var roomDetail: RoomDetail?
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
        tableView.delegate = self
        tableView.register(RoomImageViewCell.self, forCellReuseIdentifier: "RoomImageViewCell")
        tableView.register(RoomDetailViewCell.self, forCellReuseIdentifier: "RoomDetailViewCell")
        tableView.register(RoomInfoViewCell.self, forCellReuseIdentifier: "RoomInfoViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .image:
            return 1
        case .details:
            return 1
        case .info:
            return 1
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomImageViewCell", for: indexPath) as! RoomImageViewCell
            cell.configure(with: roomDetail!)
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomDetailViewCell", for: indexPath) as! RoomDetailViewCell
            cell.backgroundColor = .systemGray6
            cell.configure(with: roomDetail!)
            return cell
        case .info:
            let cell = RoomInfoViewCell()
            return cell
            
        }
    }
    
    func configure(with roomDetail: RoomDetail) {
        print(#function, "??")
        self.roomDetail = roomDetail
    }
}

