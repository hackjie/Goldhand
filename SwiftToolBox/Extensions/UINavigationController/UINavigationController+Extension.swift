//
//  UINavigationController+Extension.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

extension UINavigationController {
    /// Pop to special view controller --- 退出到指定控制器
    ///
    /// - Parameter cls: AnyClass
    public func popToViewController(_ cls: AnyClass) {
        for vc in self.viewControllers {
            if vc.isMember(of: cls) {
                self.popToViewController(vc, animated: true)
            }
        }
        self.popViewController(animated: true)
    }
}
