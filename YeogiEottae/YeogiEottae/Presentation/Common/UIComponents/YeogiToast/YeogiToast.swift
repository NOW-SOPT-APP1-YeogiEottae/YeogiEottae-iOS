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

enum YeogiToastAnimationType {
    case fadeInOut
    case pushFromBottom
}

final class YeogiToast {
    
    static let animatorForPushing = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7)
    static let animatorForDismissing = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7)
    
    static var toastView: YeogiToastView!
    static var toastWidth: CGFloat!
    static var toastHeight: CGFloat!
    static var toastViewBottomConstraint: NSLayoutConstraint!
    
    static func show (type: ToastType, animationType: YeogiToastAnimationType = .fadeInOut, duration: TimeInterval = 1, isTabBar: Bool = true, completion: (() -> Void)? = nil) {
        
        guard let window = UIWindow.current else { return }
        
        self.toastView = YeogiToastView(type: type)
        self.toastViewBottomConstraint = toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -120)
        
        window.subviews
            .filter { $0 is YeogiToastView }
            .forEach { $0.removeFromSuperview() }
        window.addSubview(toastView)
        
        switch type {
        case .soldout:
            self.toastWidth = 184
            self.toastHeight = 42
        case .deinitLike:
            self.toastWidth = 235
            self.toastHeight = 44
        case .addHotelLike:
            self.toastWidth = 314
            self.toastHeight = 60
        case .addCompare:
            self.toastWidth = 336
            self.toastHeight = 48
        case .addRoomLike:
            self.toastWidth = 297
            self.toastHeight = 48
        case .warnLimitCompare:
            self.toastWidth = 199
            self.toastHeight = 48
        }
        
        toastView.makeCornerRound(radius: CGFloat(toastHeight)/2)
        toastViewBottomConstraint.isActive = true
        toastView.snp.makeConstraints {
            //$0.bottom.equalToSuperview().inset(120)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(toastWidth)
            $0.height.equalTo(toastHeight)
        }
        
        window.layoutSubviews()
        
        switch animationType {
        case .fadeInOut:
            fadeIn(completion: {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    fadeOut(completion: {
                        completion?()
                    })
                }
            })
            
        case .pushFromBottom:
            pushFromBottom {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    dismissToBottom {
                        completion?()
                    }
                }
            }
            
        }
        
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
        
        func pushFromBottom(completion: @escaping () -> Void) {
            print(#function)
            animatorForDismissing.stopAnimation(true)
            animatorForPushing.stopAnimation(true)
            toastViewBottomConstraint.constant = toastHeight
            window.layoutIfNeeded()
            animatorForPushing.addAnimations {
                toastViewBottomConstraint.constant = -120
                window.layoutIfNeeded()
            }
            animatorForPushing.addCompletion { _ in completion() }
            animatorForPushing.startAnimation()
        }
        
        func dismissToBottom(completion: @escaping () -> Void) {
            print(#function)
            toastViewBottomConstraint.constant = -120
            animatorForDismissing.addAnimations {
                toastViewBottomConstraint.constant = toastHeight
                window.layoutIfNeeded()
            }
            animatorForDismissing.addCompletion { _ in completion() }
            animatorForDismissing.startAnimation()
        }
        
    }
}
