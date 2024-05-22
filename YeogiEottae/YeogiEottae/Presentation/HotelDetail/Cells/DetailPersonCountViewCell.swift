//
//  DetailPersonCountViewCell.swift
//  YeogiEottae
//
//  Created by  정지원 on 5/22/24.
//

import UIKit
import SnapKit

class DatePersonCountCell: UITableViewCell {
var datePersonView: DatePersonCountView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDatePersonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDatePersonView()
    }
    
    private func setupDatePersonView() {
        datePersonView = DatePersonCountView()
        contentView.addSubview(datePersonView)
        datePersonView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    func configure(withDate date: String, peopleCount: String) {
        datePersonView.dateLabel.text = date
        datePersonView.personCountLabel.text = peopleCount
    }
}
