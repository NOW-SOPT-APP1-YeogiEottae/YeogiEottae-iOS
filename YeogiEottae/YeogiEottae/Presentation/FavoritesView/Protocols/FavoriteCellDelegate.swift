//
//  FavoriteCellDelegate.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/24.
//

import UIKit

protocol FavoriteCellDelegate {
    func accommodationInfoDidTapped(id: Int)
    func roomInfoDidTapped(id: Int)
}
