//
//  SwipeCellDelegate.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/24.
//

import UIKit

protocol SwipeCellDelegate: FavoriteCellDelegate {
    func deleteItem(_ cell: UICollectionViewCell)
}
