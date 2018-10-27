//
//  UILabel+Height.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/10/27.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

extension UILabel {
    /// Use to call UILabel Height, you can use label1 on screen or create a new label2 to fit,
    /// But label2's properties needed to be same to label1
    ///
    /// - Parameter width: CGFloat
    /// - Returns: CGFloat
    func enoughHeightForLabel(_ width: CGFloat) -> CGFloat {
        let size = self.sizeThatFits(CGSize(width: width, height: CGFloat.infinity))
        return ceil(size.height) + 1
    }
}
