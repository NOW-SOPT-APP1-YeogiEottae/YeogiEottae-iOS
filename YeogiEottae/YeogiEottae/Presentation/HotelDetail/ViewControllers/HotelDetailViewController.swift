//
//  HotelDetailViewController.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/15/24.
//

import UIKit


class HotelDetailViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView!
    
    enum Section: Int, CaseIterable {
        case image, details, room
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        view.backgroundColor = .white
        navigationItem.title = "호텔 상세"
        navigationController?.navigationBar.barTintColor = .brown
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc private func shareTapped() {
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: "RoomTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension HotelDetailViewController {
    
    //Section의 갯수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
//        return Section.allCases.count
        return 3
    }
    //셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .image:
            return 1
        case .details, .room:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
                cell.configure(with: "나인트리 프리미어 호텔 서울 판교", address: "경기 성남시 수정구 심곡동 296-3", rating: "9.4 740개 평가")
                return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.backgroundColor = .orange
            return cell
        case .room:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath) as! RoomTableViewCell
            cell.backgroundColor = .blue
            return cell
        }
    }
}

