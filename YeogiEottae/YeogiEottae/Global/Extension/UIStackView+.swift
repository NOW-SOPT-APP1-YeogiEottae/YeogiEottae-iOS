//
//  UIStackView+.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/13/24.
//

import UIKit

extension UIStackView {
     func addArrangedSubviews(_ views: UIView...) {
         for view in views {
             self.addArrangedSubview(view)
         }
     }
}
