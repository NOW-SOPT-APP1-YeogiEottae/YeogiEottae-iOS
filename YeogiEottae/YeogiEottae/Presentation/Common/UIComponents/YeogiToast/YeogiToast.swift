//
//  YeogiToast.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/18/24.
//

import UIKit

import SnapKit

@frozen
enum ToastType {
    case soldout
    case deinitLike
    case addHotelLike
    case addRoomLike
    case addCompare
    case warnLimitCompare
}

final class YeogiToast {
    static func show (type: ToastType, duration: TimeInterval = 1, isTabBar: Bool = true, completion: (() -> Void)? = nil) {
        let toastView = YeogiToastView(type: type)
        let toastWidth:Int
        let toastHeight:Int
        
        switch type {
        case .soldout:
            toastWidth = 184
            toastHeight = 42
        case .deinitLike:
            toastWidth = 235
            toastHeight = 44
        case .addHotelLike:
            toastWidth = 314
            toastHeight = 60
        case .addCompare:
            toastWidth = 336
            toastHeight = 48
        case .addRoomLike:
            toastWidth = 297
            toastHeight = 48
        case .warnLimitCompare:
            toastWidth = 199
            toastHeight = 48
        }
        
        guard let window = UIWindow.current else { return }
        window.subviews
            .filter { $0 is YeogiToast }
            .forEach { $0.removeFromSuperview() }
        window.addSubview(toastView)
        
        toastView.makeCornerRound(radius: CGFloat(toastHeight)/2)
        toastView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(toastWidth)
            $0.height.equalTo(toastHeight)
        }
        
        window.layoutSubviews()
        
        fadeIn(completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                fadeOut(completion: {
                    completion?()
                })
            }
        })
        
        func fadeIn(completion: (() -> Void)? = nil) {
            toastView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                toastView.alpha = 1
            } completion: { _ in
                completion?()
            }
            
        }
        
        func fadeOut(completion: (() -> Void)? = nil) {
            toastView.alpha = 1
            UIView.animate(withDuration: 0.5) {
                toastView.alpha = 0
            } completion: { _ in
                toastView.removeFromSuperview()
                completion?()
            }
        }
    }
}
