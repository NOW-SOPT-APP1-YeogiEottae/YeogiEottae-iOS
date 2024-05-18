//
//  UIColorExtensions.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/11.
//

import UIKit

protocol ProjectColor: RawRepresentable where RawValue == String { }

enum BrandColor: String, ProjectColor {
    case brandDark = "#E14040"
    case brand = "#F45858"
    case brandLight = "#FF6A6A"
    case brandLighter = "#F98383"
    case brandLightest = "#FFEDED"
}

enum SecondaryColor: String, ProjectColor {
    case secondary700 = "#243B52"
    case secondary600 = "#1273E4"
    case secondary500 = "#1F7AE5"
    case secondary400 = "#479AF6"
    case secondary300 = "#B7D5F6"
    case secondary200 = "#ECF4FD"
    case secondary100 = "#F2F5F9" // 임의로 설정한 것. 피그마에 댓글 답변 올라오면 적용 예정x
}

enum GrayColor: String, ProjectColor {
    case gray950 = "#000000"
    case gray900 = "#333333"
    case gray850 = "#707070"
    case gray800 = "#858585"
    case gray700 = "#999999"
    case gray600 = "#ADADAD"
    case gray500 = "#C2C2C2"
    case gray400 = "#EBEBEB"
    case gray300 = "#F4F4F4"
    case gray200 = "#F5F5F5"
    case gray100 = "#FAFAFA"
    case gray0 = "#FFFFFF"
}

enum SystemColor: String, ProjectColor {
    case starLight = "#FFAD0A"
    case starDark = "#FFAC09"
    case caution = "#CA0101"
}

extension UIColor {
    
    static func brandColor(brightness: BrandColor, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(hexCode: brightness.rawValue, alpha: alpha) else { fatalError() }
        return color
    }
    
    static func secondaryColor(brightness: SecondaryColor, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(hexCode: brightness.rawValue, alpha: alpha) else { fatalError() }
        return color
    }
    
    static func grayColor(brightness: GrayColor, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(hexCode: brightness.rawValue, alpha: alpha) else { fatalError() }
        return color
    }
    
    static func systemColor(brightness: SystemColor, alpha: CGFloat = 1) -> UIColor {
        guard let color = UIColor(hexCode: brightness.rawValue, alpha: alpha) else { fatalError() }
        return color
    }
    
    /*
     코드 출처: https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
     */
    convenience init?(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        // isValidHexSixDigits 함수는 좀 더 다듬을 예정
        guard hexFormatted.isValidHexSixDigits() else { return nil }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    
}


