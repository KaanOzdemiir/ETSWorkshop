//
//  FontFace.swift
//  ETSWorkshop
//
//  Created by Kaan Ozdemir on 17.04.2021.
//

import Foundation
import UIKit

class FontFace {
    
    static var defaultFontFamily = "Rubik"
    
    
    static func regularFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-Regular.ttf", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func semiBoldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "\(defaultFontFamily)-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
    }
}

