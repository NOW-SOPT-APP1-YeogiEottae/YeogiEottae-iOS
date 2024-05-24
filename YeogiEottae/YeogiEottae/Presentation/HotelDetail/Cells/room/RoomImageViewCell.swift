//
//  RoomImageViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit

import SnapKit
import Moya

class RoomImageViewCell: UITableViewCell {
    
    var provider = MoyaProvider<FavoritesListTargetType>(plugins: [MoyaLoggingPlugin()])
    
    var roomDetail: RoomDetail?
    var roomID: Int = 0
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
    let roomImageView = UIImageView()
    let nameLabel = UILabel()
    let cautionLabel: UILabel = {
        let label = UILabel()
        label.text = "무료취소 불가"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setButtonsAction()
        
        self.provider.request(.addToFavorites(isRoom: true, id: self.roomID)) { result in
            self.heartButton.isSelected = self.roomDetail!.isLiked
        }
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
        addSubview(roomImageView)
        
        nameLabel.font = UIFont.projectFont(name: .h3)
        nameLabel.textColor = UIColor.grayColor(brightness: .gray950)
        nameLabel.numberOfLines = 2
        
        cautionLabel.font = UIFont.projectFont(name: .h6)
        cautionLabel.textColor = UIColor.grayColor(brightness: .gray700)
        
        addSubview(heartButton)
        addSubview(nameLabel)
        addSubview(cautionLabel)
        addSubview(roomImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        roomImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(375)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(30)
            make.right.equalTo(roomImageView).inset(20)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(roomImageView.snp.bottom).offset(26)
            make.left.equalTo(roomImageView).inset(20)
        }
        
        cautionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.left.equalTo(roomImageView).inset(20)
            make.bottom.equalToSuperview().inset(27)
        }
    }
    
    private func setButtonsAction() {
        self.heartButton.addTarget(self, action: #selector(heartButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonDidTapped() {
        print(#function)
        self.heartButton.isSelected.toggle()
        self.isFavorite.toggle()
        switch self.isFavorite {
        case true:
            YeogiToast.show(type: .addRoomLike, animationType: .pushFromBottom)
        case false:
            YeogiToast.show(type: .deinitLike, animationType: .pushFromBottom)
        }
    }
    
    func configure(with name: String, image: UIImage) {
        nameLabel.text = name        
        roomImageView.image = image
    }
    
    func configure(with roomDetail: RoomDetail) {
        self.roomDetail = roomDetail
        self.roomID = roomDetail.roomID
        nameLabel.text = roomDetail.roomName
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
    




