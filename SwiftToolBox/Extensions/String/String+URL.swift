//
//  String+URL.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2019/3/13.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

extension String {
    /// Return valid URL
    ///
    /// - Returns: URL
    func validURL() -> URL? {
        // Delete space and newlines character
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check for existing percent escapes first to prevent double-escaping of % character
        if str.range(of: "%[0-9A-Fa-f]{2}", options: .regularExpression, range: nil, locale: nil) != nil {
            return URL(string: str)
        } else if let encodedString = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: encodedString)
        } else {
            return nil
        }
    }
    
    /// Return valid URL String
    ///
    /// - Returns: String
    func validURLString() -> String? {
        // Delete space and newlines character
        let str = self.trimmingCharacters(in: .whitespacesAndNewlines)
        // Check for existing percent escapes first to prevent double-escaping of % character
        if str.range(of: "%[0-9A-Fa-f]{2}", options: .regularExpression, range: nil, locale: nil) != nil {
            return str
        } else if let encodedString = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return encodedString
        } else {
            return nil
        }
    }
    
    /// Return Decoded String
    ///
    /// - Returns: String
    func decodedString() -> String? {
        return self.removingPercentEncoding
    }
}
