//
//  StringExtensions.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/12.
//

import Foundation
import UIKit

extension String {
    
    func isValidHexSixDigits() -> Bool {
        guard let regex = try? NSRegularExpression(pattern: "^[0-9a-fA-F]{6}$") else { return false }
        let range = NSRange(location: 0, length: self.count)
        //let result = regex.numberOfMatches(in: self, range: range)
        let result = regex.rangeOfFirstMatch(in: self, range: range).length
        return result == 6 ? true : false
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
}
