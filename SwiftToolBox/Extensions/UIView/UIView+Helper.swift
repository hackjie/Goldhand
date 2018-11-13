//
//  UIView+Helper.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

private var LJTapActionBlockKey: String = "LJTapActionBlockKey"

extension UIView {
    /// UIViewController of UIView --- 视图所在控制器
    ///
    /// - Returns: UIViewController
    public func atViewController() -> UIViewController? {
        var view: UIView? = self
        repeat {
            if let nextResponder = view?.next {
                if let viewController = (nextResponder as? UIViewController) {
                    return viewController
                } else {
                    view = view?.superview
                }
            } else {
                return nil
            }
        } while view != nil
        return nil
    }
}

extension UIView {
    /// Add tap block --- 添加点击回调操作
    var tapActionBlock: (() -> Void)? {
        set {
            objc_setAssociatedObject(self, &LJTapActionBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            if self is UIButton {
                let button = self as! UIButton
                button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
            } else {
                self.isUserInteractionEnabled = true
                self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
            }
        }
        get {
            return objc_getAssociatedObject(self, &LJTapActionBlockKey) as? (() -> Void)
        }
    }
    
    @objc private func tapAction() {
        if self.tapActionBlock != nil {
            self.tapActionBlock!()
        }
    }
}
