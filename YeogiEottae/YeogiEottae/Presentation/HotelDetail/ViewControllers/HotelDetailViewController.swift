//
//  HotelDetailViewController.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit

class HotelDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    var hotelDetailDTO: GetHotelDetailResponseDTO? = nil
    var hotelImageURL: String = ""
    var hotelID: Int = 0 {
        didSet {
            //네트워크 통신 코드
            print("????")
            HotelDetailService.shared.getHotelDetailData(hotelID: self.hotelID) { result in //thread1에서 작동되는 내용
                switch result {
                case .success(let data):
                    guard let hotelDetailDTO = data as? GetHotelDetailResponseDTO else { fatalError() }
                    
                    self.hotelDetailDTO = hotelDetailDTO
                    
                    //(공식문서) 원래 reloadData()는 메인 스레드에서만 작동되어야함. 하지만 thread1의 코드 내부에 있으므로 DispatchQueue.main.async 코드를 통해 메인스레드에서 작동되도록 시킴.
                    DispatchQueue.main.async {
                        self.tableView.reloadData() //tableView의 데이터를 다시 갱신하는 것(UITableViewDataSource의 함수인 cellForItemAt 함수를 다시 호출하게 됨) UI가 api 연결 완료되기 전에 그려졌더라도 api 연결 후 UI가 갱신되도록 함.
                    }
                    
                    
                    let hotelDetail = hotelDetailDTO.hotelDetail
                    print("hotel name is", hotelDetail.hotelName)
                    print("hotel location is", hotelDetail.location)
                    print("hotel rate is", hotelDetail.reviewRate)
                    
                    
                case .requestErr:
                    fatalError()
                case .decodedErr:
                    fatalError()
                case .pathErr:
                    fatalError()
                case .serverErr:
                    fatalError()
                case .networkFail:
                    fatalError()
                }
            }
            
        }
    }
    
    enum Section: Int, CaseIterable {
        case image, details, room
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        //navigationItem.title = StringLiteral.HotelDetail.hotelDetail
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = shareItem
    }
    
    @objc private func shareTapped() {
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: "RoomTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        //.never로 설정했는데 왜 이미지가 끝까지 나타나지 않지?
        tableView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = Section(rawValue: section) else { return nil }
        
        switch sectionType {
        case .room:
            return DateRangeHeaderView()
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionType = Section(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .room:
            return 44
        default:
            return 0.1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.configure(
                with: "나인트리 프리미어 호텔 서울 판교",
                more: "지도 보기",
                moreReview: "리뷰 보기",
                address: "경기 성남시 수정구 심곡동 296-3",
                rating: "9.4",
                review: "740개 평가"
            )
            
            cell.configure(with: self.hotelDetailDTO, imageURL: self.hotelImageURL)
            return cell
        case .details:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            let logoImage1 = UIImage(named: "price")
            let logoImage2 = UIImage(named: "gift")
            if indexPath.row == 0 {
                cell.configure(
                    logoImage: logoImage1,
                    title: "결제 혜택",
                    more: "더보기",
                    payment: "토스페이", paymentMethodImage: UIImage(named: "imgTosspay"),
                    detail1: "• 3만원 이상 10% 5천원 캐시백 (월 2회, 일 300...",
                    detail2: "• 2만원 이상, 2천원 할인 (월 4회, 일 800명)",
                    detail3: "• +생애 첫결제 시, 5천원 캐시백"
                )
            } else {
                cell.configure(
                    logoImage: logoImage2,
                    title: "숙소 이벤트",
                    more: "더보기",
                    detail1: "• 자유로운 이체는 미국을 타운 [계좌 환전]",
                    detail2: "• 시간 가는 줄 모르는 Let's Puzzle",
                    detail3: "• 아이들이 좋아하는 #티니핑월드"
                )
            }
            return cell
        case .room:            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomTableViewCell.reuseIdentifier, for: indexPath) as? RoomTableViewCell,
                  let roomDetails = hotelDetailDTO?.hotelDetail.roomList, indexPath.row < roomDetails.count else {
                return UITableViewCell()
            }
            let roomDetail = roomDetails[indexPath.row]
            cell.configure(with: roomDetail)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let section = Section(rawValue: indexPath.section), section == .room else {
                return
            }
            
            let roomDetailVC = RoomDetailViewController()
            if let roomDetails = hotelDetailDTO?.hotelDetail.roomList, indexPath.row < roomDetails.count {
                let roomDetail = roomDetails[indexPath.row]
                roomDetailVC.configure(with: roomDetail)
            }
            navigationController?.pushViewController(roomDetailVC, animated: true)
        }
}


