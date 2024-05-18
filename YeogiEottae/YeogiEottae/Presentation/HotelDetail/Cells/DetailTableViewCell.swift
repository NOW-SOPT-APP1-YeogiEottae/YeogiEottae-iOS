//
//  DetailTableViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/18/24.
//
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Hello world"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
