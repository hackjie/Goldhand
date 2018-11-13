//
//  UIView+Windless.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

let kWindlessViewTag = 91997

extension UIView {
    /// Add windless view for weak network --- 为视图添加弱网效果
    ///
    /// - Parameter isWindless: 是否为弱网状态
    public func windless(isWindless: Bool) {
        var windLessView: UIView? = self.viewWithTag(kWindlessViewTag)
        if isWindless {
            if windLessView == nil {
                // 添加弱网视图
                windLessView = UIView(frame: self.bounds)
                windLessView!.backgroundColor = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
                windLessView?.layer.position    = CGPoint(x: 0, y: 0)
                windLessView?.layer.anchorPoint = CGPoint(x: 0, y: 0)
                windLessView!.tag = kWindlessViewTag
                self.addSubview(windLessView!)
            }
            // 添加动画
            let random = CGFloat(self.randomNum(start: 4, end: 6)) / 10.0
            let minW = self.bounds.size.width * random
            let maxW = self.bounds.size.width * 1.0
            let animation = CABasicAnimation(keyPath: "bounds.size.width")
            animation.duration      = 1
            animation.repeatCount   = MAXFLOAT
            animation.autoreverses  = true
            animation.fromValue     = CGFloat(minW)
            animation.toValue       = CGFloat(maxW)
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            windLessView!.layer.add(animation, forKey: "WindlessAnimation")
        } else {
            guard windLessView != nil else {
                return
            }
            // 移除弱网视图
            windLessView?.removeFromSuperview()
        }
    }
    
    /// 获取（start~end）的随机数(为了让动画更好看)
    fileprivate func randomNum(start: Int, end: Int) -> Int {
        var temp = Int(arc4random_uniform(UInt32(end))) + 1
        if temp < start {
            temp = self.randomNum(start: start, end: end)
        }
        return temp
    }
}
