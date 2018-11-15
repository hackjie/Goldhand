//
//  String+Currency.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/10/27.
//  Copyright © 2018年 李杰. All rights reserved.
//

import Foundation

// MARK: - Format
extension String {
    /// Double String format --- 数字格式化
    ///
    /// - Parameter f: String
    /// - Returns: Optional String
    func format(_ f: String) -> String? {
        if let value = Double(self) {
            let str = String(format: "%\(f)f", value)
            return str
        } else {
            return nil
        }
    }
    
    /// String separated by comma --- 金额用逗号隔开处理
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
    
    /// String without zero at the end  --- 最大保留小数点后两位小数，小数点后结尾有0去掉
    ///
    /// - Returns: String
    public func decimalStringWithoutZero() -> String? {
        let number = NSNumber(value: Double(self) ?? 0)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number)
    }
    
    /// Percent String --- 百分数处理
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
