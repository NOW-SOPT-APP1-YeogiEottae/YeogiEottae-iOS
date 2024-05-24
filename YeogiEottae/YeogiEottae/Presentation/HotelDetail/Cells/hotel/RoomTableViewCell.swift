//
//  RoomTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//

import UIKit

import SnapKit
import Moya

class RoomTableViewCell: UITableViewCell {
    static let reuseIdentifier = "RoomTableViewCell"
    
    var provider = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    
    var roomDetail: RoomDetail? = nil
    let roomImageView = UIImageView()
    var roomTypeLabel = UILabel()
    let priceLabel = UILabel()
    let bookingInfoLabel = UILabel()
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.roomInfo
        return label
    }()
    let info: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.HotelDetail.roomPerson
        return label
    }()
    var isFavorite: Bool = false
    var heartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "like20")
        configuration.background.backgroundColor = UIColor.grayColor(brightness: .gray200)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(named: "like20"), for: .normal)
        button.setImage(
            UIImage(named: "like20")?.withTintColor(.brandColor(brightness: .brand), renderingMode: .alwaysOriginal),
            for: .selected
        )
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setButtonsAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.heartButton.convert(self.heartButton.bounds, to: self.contentView).contains(point) {
            return self.heartButton
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    private func setupViews() {
        
        roomImageView.contentMode = .scaleAspectFill
        roomImageView.clipsToBounds = true
        roomImageView.layer.cornerRadius = 10
        
        roomTypeLabel.font = UIFont.projectFont(name: .h3)
        roomTypeLabel.textColor = UIColor.grayColor(brightness: .gray950)
        
        priceLabel.font = UIFont.projectFont(name: .h3)
        priceLabel.textColor = UIColor.grayColor(brightness: .gray950)
        priceLabel.textAlignment = .right
        
        bookingInfoLabel.font = UIFont.projectFont(name: .l6)
        bookingInfoLabel.textColor = UIColor.grayColor(brightness: .gray700)
        bookingInfoLabel.textAlignment = .right
        
        let infoView = UIView()
        infoView.backgroundColor = UIColor.grayColor(brightness: .gray100)
        infoView.layer.cornerRadius = 8
        
        infoLabel.font = UIFont.projectFont(name: .l8)
        infoLabel.textColor = UIColor.grayColor(brightness: .gray700)
        infoLabel.textAlignment = .left
        
        info.font = UIFont.projectFont(name: .b7)
        info.textColor = UIColor.secondaryColor(brightness: .secondary700)
        info.textAlignment = .left
        
        contentView.addSubview(infoView)
        contentView.addSubview(roomImageView)
        contentView.addSubview(roomTypeLabel)
        contentView.addSubview(heartButton)
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(bookingInfoLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(info)
        
        roomImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(19)
            make.height.equalTo(200)
        }
        
        roomTypeLabel.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(24)
            make.left.equalToSuperview().inset(19)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(15)
            make.right.equalToSuperview().inset(19)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(roomTypeLabel.snp.top).offset(20)
            make.right.equalToSuperview().inset(19)
        }
        
        bookingInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(19)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(bookingInfoLabel.snp.bottom).offset(18)
            make.left.right.bottom.equalToSuperview().inset(19)
            make.height.equalTo(38)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(infoView.snp.left).inset(12)
            make.centerY.equalTo(infoView)
        }
        
        info.snp.makeConstraints { make in
            make.left.equalTo(infoLabel.snp.right).offset(31)
            make.centerY.equalTo(infoView)
        }
        
        
    }
    
    private func setButtonsAction() {
        self.heartButton.addTarget(self, action: #selector(heartButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonDidTapped() {
        print(#function)
        self.heartButton.isSelected.toggle()
        self.isFavorite.toggle()
        
        
        self.provider.request(.addToFavorites(isRoom: true, id: self.roomDetail!.roomID)) { result in
            
        }
        
        switch self.isFavorite {
        case true:
            YeogiToast.show(type: .addRoomLike, animationType: .pushFromBottom)
        case false:
            YeogiToast.show(type: .deinitLike, animationType: .pushFromBottom)
        }
    }
    
    func configure(image: UIImage, roomType: String, price: String, bookingInfo: String) {
        roomImageView.image = image
        roomTypeLabel.text = roomType
        priceLabel.text = price
        bookingInfoLabel.text = bookingInfo
    }
    
    func configure(with roomDetail: RoomDetail) {
        self.roomDetail = roomDetail
        roomTypeLabel.text = roomDetail.roomName
        priceLabel.text = "\(roomDetail.price)원"
        bookingInfoLabel.text = "입실 \(roomDetail.startTime) 퇴실 \(roomDetail.endTime)"
        self.isFavorite = roomDetail.isLiked
        self.heartButton.isSelected = self.isFavorite
        
        if let imageUrl = URL(string: roomDetail.imageURL){
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.roomImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
