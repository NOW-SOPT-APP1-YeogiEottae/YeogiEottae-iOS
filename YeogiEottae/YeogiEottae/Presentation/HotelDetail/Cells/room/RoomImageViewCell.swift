//
//  RoomImageViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit
import SnapKit

class RoomImageViewCell: UITableViewCell {
    
    var heartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "like20")
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let button = UIButton(configuration: configuration)
        button.backgroundColor = UIColor.grayColor(brightness: .gray200)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func heartButtonTapped() {
        print("Heart button tapped")
    }
    
    
    private func setupViews() {
        roomImageView.contentMode = .scaleAspectFill
        roomImageView.clipsToBounds = true
        addSubview(roomImageView)
        
        heartButton.setImage(UIImage(named: "like20")?.withRenderingMode(.alwaysOriginal), for: .normal)
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        
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
    
    func configure(with name: String) {
        nameLabel.text = name
        
        roomImageView.image = UIImage(named: "hotel1")
    }
    
    func configure(with roomDetail: RoomDetail) {
        nameLabel.text = roomDetail.roomName
        
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


