//
//  HotelDetailViewController.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
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
        navigationItem.title = "호텔 상세"
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
        case .details:
            return 2
        case .room:
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
            cell.configure(with: "나인트리 프리미어 호텔 서울 판교", more: "지도 보기", moreReview: "리뷰 보기", address: "경기 성남시 수정구 심곡동 296-3", rating: "9.4", review: "740개 평가")
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            let logoImage1 = UIImage(named: "price")
            let logoImage2 = UIImage(named: "gift")
            if indexPath.row == 0 {
                cell.configure(logoImage: logoImage1, title: "결제 혜택", more: "더보기", detail1: "• 3만원 이상 10% 청구할인 (월 2회, 일 300...", detail2: "• 2만원 이상, 2천원 할인 (월 4회, 일 800명)", detail3: "• +생애 첫결제 시, 5천원 캐시백")
            } else {
                cell.configure(logoImage: logoImage2, title: "숙소 이벤트", more: "더보기", detail1: "• 자유로운 이체는 미국을 타운 [계좌 환전]", detail2: "• 시간 가는 줄 모르는 Let's Puzzle", detail3: "• 아이들이 좋아하는 #티니핑월드")
            }
            return cell
        case .room:
            let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.reuseIdentifier, for: indexPath) as! RoomTableViewCell
            let roomType = indexPath.row == 0 ? "스탠다드 더블룸" : "패밀리 스위트"
            let price = indexPath.row == 0 ? "156,900원" : "356,900원"
            let bookingInfo = "입실 15:00 탈실 11:00"
            let image = UIImage(named: "room1") ?? UIImage()  // "room1"이 없을 경우 빈 이미지
            cell.configure(image: image, roomType: roomType, price: price, bookingInfo: bookingInfo)
            return cell
            
        }
    }
}


