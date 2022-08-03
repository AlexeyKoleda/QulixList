//
//  UIColor+Theme.swift
//  QulixList
//
//  Created by Alexey Koleda on 03.08.2022.
//

import Foundation
import UIKit

extension UIColor {
    static let theme = ColorTheme()
    
    struct ColorTheme {
        let additionalTextColor = UIColor(named: "additionalTextColor")!
        
        let lightBackgroundColor = UIColor(named: "lightBackgroundColor")!
        let darkBackgroundColor = UIColor(named: "darkBackgroundColor")!
        
        let navigationBarColor = UIColor(named: "navigationBarColor")!
        let discountPriceColor = UIColor(named: "discountPriceColor")!
        let linkColor = UIColor(named: "linkColor")!
    }
}


