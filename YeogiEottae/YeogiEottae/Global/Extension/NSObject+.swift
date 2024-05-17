//
//  NSObject+.swift
//  YeogiEottae
//
//  Created by Seonwoo Kim on 5/16/24.
//

import Foundation


extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
