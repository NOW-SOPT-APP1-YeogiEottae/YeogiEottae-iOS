//
//  UIFontExtensions.swift
//  YeogiEottae
//
//  Created by 김민성 on 2024/05/12.
//

import UIKit

enum PretendardFont: CGFloat {
    case thin = 100
    case extraLight = 200
    case light = 300
    case regular = 400
    case medium = 500
    case semiBold = 600
    case bold = 700
    case extraBold = 800
    case Black = 900
}


enum projectFontName {
    case h1 //(weight: CGFloat = 750, size: CGFloat = 23)
    case h2 //(weight: CGFloat = 750, size: CGFloat = 20)
    case h3 //(weight: CGFloat = 700, size: CGFloat = 17)
    case h4 //(weight: CGFloat = 700, size: CGFloat = 15)
    case h5 //(weight: CGFloat = 700, size: CGFloat = 14)
    case h6 //(weight: CGFloat = 700, size: CGFloat = 13)
    
    case b1 //(weight: CGFloat = 600, size: CGFloat = 16)
    case b2 //(weight: CGFloat = 400, size: CGFloat = 16)
    case b3 //(weight: CGFloat = 600, size: CGFloat = 15)
    case b4 //(weight: CGFloat = 400, size: CGFloat = 15)
    case b5 //(weight: CGFloat = 500, size: CGFloat = 14)
    case b6 //(weight: CGFloat = 400, size: CGFloat = 13)
    case b7 //(weight: CGFloat = 600, size: CGFloat = 11)
    
    case l1 //(weight: CGFloat = 700, size: CGFloat = 13)
    case l2 //(weight: CGFloat = 600, size: CGFloat = 13)
    case l3 //(weight: CGFloat = 700, size: CGFloat = 12)
    case l4 //(weight: CGFloat = 600, size: CGFloat = 12)
    case l5 //(weight: CGFloat = 500, size: CGFloat = 12)
    case l6 //(weight: CGFloat = 400, size: CGFloat = 12)
    case l7 //(weight: CGFloat = 600, size: CGFloat = 10)
    case l8 //(weight: CGFloat = 600, size: CGFloat = 11)
}

extension UIFont {
    
    /// (Figma에서) 특정 폰트의 weight가 수치로 표현되어있을 때, 각 두께로 바꿔서 UIFont 인스턴스를 반환함.
    /// - Parameters:
    ///   - fontSize: font의 사이즈
    ///   - weight: font의 weight
    /// - Returns: 특정 size와 weight의 UIFont 인스턴스
    static func pretendardFont(ofSize fontSize: CGFloat, weight: CGFloat) -> UIFont {
        let fontName: String
        
        switch weight {
        case PretendardFont.thin.rawValue:
            fontName = "Pretendard-Thin"
        case PretendardFont.extraLight.rawValue:
            fontName = "Pretendard-ExtraLight"
        case PretendardFont.light.rawValue:
            fontName = "Pretendard-Light"
        case PretendardFont.regular.rawValue:
            fontName = "Pretendard-Regular"
        case PretendardFont.medium.rawValue:
            fontName = "Pretendard-Medium"
        case PretendardFont.semiBold.rawValue:
            fontName = "Pretendard-SemiBold"
        case PretendardFont.bold.rawValue:
            fontName = "Pretendard-Bold"
        case PretendardFont.extraBold.rawValue:
            fontName = "Pretendard-ExtraBold"
        case PretendardFont.Black.rawValue:
            fontName = "Pretendard-Black"
        default:
            fatalError("Invalid weight")
        }
        
        guard let font = UIFont(name: fontName, size: fontSize) else { fatalError("Font not found") }
        return font
    }
}


extension UIFont {
    
    /// Pretendard 폰트의 특정 weight를 이용해 Pretendard 폰트의 UIFont 인스턴스를 반환 (마치 systemFont처럼)
    /// - Parameters:
    ///   - fontSize: font의 사이즈
    ///   - weight: font의 weight
    /// - Returns: 특정 size와 weight의 UIFont 인스턴스
    static func pretendardFont(ofSize fontSize: CGFloat, weight: PretendardFont) -> UIFont {
        let fontName: String
        switch weight {
        case .thin:
            fontName = "Pretendard-Thin"
        case .extraLight:
            fontName = "Pretendard-ExtraLight"
        case .light:
            fontName = "Pretendard-Light"
        case .regular:
            fontName = "Pretendard-Regular"
        case .medium:
            fontName = "Pretendard-Medium"
        case .semiBold:
            fontName = "Pretendard-SemiBold"
        case .bold:
            fontName = "Pretendard-Bold"
        case .extraBold:
            fontName = "Pretendard-ExtraBold"
        case .Black:
            fontName = "Pretendard-Black"
        }
        
        guard let font = UIFont(name: fontName, size: fontSize) else { fatalError("Font not found") }
        return font
    }
    
    
    
    
    static func projectFont(name: projectFontName) -> UIFont {
        switch name {

        case .h1: return UIFont.pretendardFont(ofSize: 23, weight: 800)
        case .h2: return UIFont.pretendardFont(ofSize: 20, weight: 800)
        case .h3: return UIFont.pretendardFont(ofSize: 17, weight: 700)
        case .h4: return UIFont.pretendardFont(ofSize: 15, weight: 700)
        case .h5: return UIFont.pretendardFont(ofSize: 14, weight: 700)
        case .h6: return UIFont.pretendardFont(ofSize: 13, weight: 700)
            
        case .b1: return UIFont.pretendardFont(ofSize: 16, weight: 600)
        case .b2: return UIFont.pretendardFont(ofSize: 16, weight: 400)
        case .b3: return UIFont.pretendardFont(ofSize: 15, weight: 600)
        case .b4: return UIFont.pretendardFont(ofSize: 15, weight: 400)
        case .b5: return UIFont.pretendardFont(ofSize: 14, weight: 500)
        case .b6: return UIFont.pretendardFont(ofSize: 13, weight: 400)
        case .b7: return UIFont.pretendardFont(ofSize: 11, weight: 600)
            
        case .l1: return UIFont.pretendardFont(ofSize: 13, weight: 700)
        case .l2: return UIFont.pretendardFont(ofSize: 13, weight: 600)
        case .l3: return UIFont.pretendardFont(ofSize: 12, weight: 700)
        case .l4: return UIFont.pretendardFont(ofSize: 12, weight: 500)
        case .l5: return UIFont.pretendardFont(ofSize: 12, weight: 500)
        case .l6: return UIFont.pretendardFont(ofSize: 12, weight: 400)
        case .l7: return UIFont.pretendardFont(ofSize: 10, weight: 600)
        case .l8: return UIFont.pretendardFont(ofSize: 11, weight: 600)
            
        }
    }
    
}



