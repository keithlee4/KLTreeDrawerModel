//
//  UIColor+Hex.swift
//  KLTreeDrawerModel
//
//  Created by keith.lee on 2016/10/3.
//  Copyright © 2016年 Keith. All rights reserved.
//

import UIKit
extension UIColor {
    static func colorWith(hex:Int) -> UIColor {
        let hexRed = Float((hex & 0xFF0000) >> 16) / 255.0
        let hexGreen = Float((hex & 0x00FF00) >> 8) / 255.0
        let hexBlue = Float((hex & 0x0000FF) >> 0) / 255.0
        
        return UIColor(colorLiteralRed: hexRed, green: hexGreen, blue: hexBlue, alpha: 1.0)
    }
}
