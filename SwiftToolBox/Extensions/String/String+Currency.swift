//
//  String+Currency.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/10/27.
//  Copyright © 2018年 李杰. All rights reserved.
//

import Foundation

extension String {
    /// String separated by comma
    ///
    /// - Parameter maximumFractionDigits: Int
    /// - Returns: Optional String
    func stringSeparateByComma(_ maximumFractionDigits: Int = 2) -> String? {
        let number = NSNumber(value: Double(self) ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSize = 3
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: number)
    }
    
    /// Percent String
    ///
    /// - Parameter maximumFractionDigits: Int
    /// - Returns: Optional String
    func percentString(_ maximumFractionDigits: Int = 2) -> String? {
        let number = NSNumber(value: Double(self) ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = maximumFractionDigits
        return numberFormatter.string(from: number)
    }
}
