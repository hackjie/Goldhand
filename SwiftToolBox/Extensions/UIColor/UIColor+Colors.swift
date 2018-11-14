//
//  UIColor+Colors.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/14.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

extension UIColor {
    /// Random color --- 随机色
    public class var randomColor: UIColor {
        return UIColor.color(red: CGFloat(arc4random() % 256),
                             green: CGFloat(arc4random() % 256),
                             blue: CGFloat(arc4random() % 256))
    }
    
    /// Get color with RGB value --- 直接通过 RGBA 值创建 UIColor
    ///
    /// - Parameters:
    ///   - red: CGFloat
    ///   - green: CGFloat
    ///   - blue: CGFloat
    ///   - alpha: CGFloat
    /// - Returns: UIColor
    public class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    /// Get color with hex value --- 用十六进制数值初始化颜色
    ///
    /// - Parameters:
    ///   - valueRGB: UInt
    ///   - alpha: alpha
    public convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
