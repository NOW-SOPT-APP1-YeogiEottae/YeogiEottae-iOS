//
//  AccomodationKindSegmentController.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/13.
//

import UIKit
import SnapKit

final class AccomodationKindSegmentController: UIScrollView {
    
    let allKindLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.allKind
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let motelLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.motel
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let hotelResortLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.hotelResort
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let pensionLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.pension
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let homeVillaLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.homeVilla
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let campingLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.camping
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let guestHouseHanokLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiteral.AccommodationKindSegmentName.guestHouseHanok
        label.textColor = .black
        label.font = UIFont.projectFont(name: .b2) //selected 시에는 b1
        return label
    }()
    
    let underBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.grayColor(brightness: .gray200)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.setUI()
        self.configureViewHierarchy()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }
    
    
    private func configureViewHierarchy() {
        self.addSubviews(
            self.allKindLabel,
            self.motelLabel,
            self.hotelResortLabel,
            self.pensionLabel,
            self.homeVillaLabel,
            self.campingLabel,
            self.guestHouseHanokLabel,
            self.underBar
        )
    }
    
    private func setConstraints() {
        self.allKindLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(19)
        }
        
        self.motelLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.allKindLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
        self.hotelResortLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.motelLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
        self.pensionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.hotelResortLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
        self.homeVillaLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.pensionLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
        self.campingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.homeVillaLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
        }
        
        self.guestHouseHanokLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(13)
            make.leading.equalTo(self.campingLabel.snp.trailing).offset(24)
            make.height.equalTo(19)
            make.trailing.equalToSuperview().inset(24)
        }
        
        self.underBar.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
    }
    
}
