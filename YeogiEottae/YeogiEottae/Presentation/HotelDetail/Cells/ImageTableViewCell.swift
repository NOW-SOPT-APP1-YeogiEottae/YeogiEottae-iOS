//
//  ImageTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//
import UIKit
import SnapKit

class ImageTableViewCell: UITableViewCell {
    
    let hotelImageView = UIImageView()
    let nameLabel = UILabel()
    let addressLabel = UILabel()
    let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        hotelImageView.contentMode = .scaleAspectFill
        hotelImageView.clipsToBounds = true
        addSubview(hotelImageView)
        
        // Configure labels with a semi-transparent background
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
        nameLabel.backgroundColor = .black
        
        addressLabel.font = UIFont.systemFont(ofSize: 16)
        addressLabel.textColor = .white
        addressLabel.backgroundColor = .black
        
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        ratingLabel.textColor = .white
        ratingLabel.backgroundColor = .black
        
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(ratingLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        hotelImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(375)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(hotelImageView.snp.top).offset(20)
            make.left.right.equalTo(hotelImageView).inset(10)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalTo(hotelImageView).inset(10)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(5)
            make.left.right.equalTo(hotelImageView).inset(10)
        }
    }
    
    func configure(with name: String, address: String, rating: String) {
        nameLabel.text = name
        addressLabel.text = address
        ratingLabel.text = rating

        hotelImageView.image = UIImage(named: "hotel1")
    }
}


