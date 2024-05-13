//
//  UIWindow+.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/13/24.
//

import UIKit

extension UIWindow {
    public static var current: UIWindow? {
        UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
}
