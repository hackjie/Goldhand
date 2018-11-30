//
//  UIView+Extensions.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/30.
//  Copyright © 2018 李杰. All rights reserved.
//

import UIKit

extension UIView {
    /// Add multiple subviews in a single line
    /// view.addSubViews(imageView, button, view, label)
    ///
    /// - Parameter subviews: sub UIViews
    public func addSubViews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
