//
//  FavoriteCellProtocol.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/24.
//

import UIKit

protocol FavoriteCellProtocol {
    
    var tapGestureRecognizerForAccommodationInfo: UITapGestureRecognizer { get }
    var tapGestureRecognizerForRoomInfo: UITapGestureRecognizer { get }
    
    func setGestureRecognizers()
}
