//
//  String+Extensions.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/10/27.
//  Copyright © 2018年 李杰. All rights reserved.
//

import Foundation

extension String {
    /// According to the key to get localized string
    ///
    /// - Parameter key: key
    /// - Returns: String
    static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
