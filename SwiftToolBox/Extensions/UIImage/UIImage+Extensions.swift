//
//  UIImage+Extensions.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

extension UIImage {
    /// Create Image from color --- 根据一个颜色创建一个UIImage
    ///
    /// - Parameter color: 颜色
    /// - Returns: UIImaged?
    static public func createImageFromColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let theImage =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if theImage != nil {
            return theImage!
        }
        return nil
    }
}
