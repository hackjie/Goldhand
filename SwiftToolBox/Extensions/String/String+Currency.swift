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
    /// Double String format
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

// MARK: - Check format
extension String {
    /// Use regular expression to check format
    ///
    /// - Parameter pattern: String
    /// - Returns: Bool
    func matchRegular(_ pattern: String) -> Bool {
        return self.range(of: pattern,
                          options: String.CompareOptions.regularExpression,
                          range: nil,
                          locale: nil) != nil
    }
    
    /// Check IP
    ///
    /// - Returns: Bool
    func isIpAddressString() -> Bool {
        let regex = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        return matchRegular(regex)
    }
    
    /// Check number
    ///
    /// - Returns: Bool
    func isNumberString() -> Bool {
        guard !self.isEmpty else { return false }
        let regularExpression = "^[0-9]*$"
        return matchRegular(regularExpression)
    }
}
