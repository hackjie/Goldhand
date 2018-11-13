//
//  UIView+Draw.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

extension UIView {
    /// Screenshot of UIView --- 视图截图
    ///
    /// - Returns: UIImage
    public func imageFromView() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            self.layer.render(in: context)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    /// Set part of cornerRadius for UIView --- 部分圆角
    ///
    /// - Parameters:
    ///   - corners: UIRectCorner --- 需要实现为圆角的角，可传入多个
    ///   - radii: CGFloat --- 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// Set cornerRadius for UIView --- 设置圆角
    ///
    /// - Parameter radius: CGFloat
    public func cornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius  = radius
        self.clipsToBounds = true
    }
    
    /// Draw dash line for UIView --- 画虚线
    ///
    /// - Parameters:
    ///   - lineDashLength: Int --- 实现长度
    ///   - lineSpacing: Int --- 空白长度
    ///   - lineColor: UIColor --- 实线颜色
    func drawLineOfDash(lineDashLength: Int,
                        lineSpacing: Int,
                        lineColor: UIColor) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 虚线
        shapeLayer.strokeColor = lineColor.cgColor
        // 宽度
        shapeLayer.lineWidth = self.frame.height
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = NSArray(array: [NSNumber(value: lineDashLength), NSNumber(value: lineSpacing)]) as? [NSNumber]
        // 路径
        let path = UIBezierPath()
        let startPointX: CGFloat = 0
        let startPointY: CGFloat = 0
        let endPointX = startPointX + self.frame.width
        let endPointY = startPointY
        path.move(to: CGPoint(x: startPointX, y: startPointY))
        path.addLine(to: CGPoint(x: endPointX, y: endPointY))
        shapeLayer.path = path.cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
