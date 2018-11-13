//
//  String+Check.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import Foundation

// MARK: - Check format
extension String {
    /// Use regular expression to check format --- 用正则匹配检查格式
    ///
    /// - Parameter pattern: String
    /// - Returns: Bool
    func matchRegular(_ pattern: String) -> Bool {
        return self.range(of: pattern,
                          options: String.CompareOptions.regularExpression,
                          range: nil,
                          locale: nil) != nil
    }
    
    /// Check IP --- 检查 IP
    ///
    /// - Returns: Bool
    func isIpAddressString() -> Bool {
        let regex = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        return matchRegular(regex)
    }
    
    /// Check Password combine number with char in [6 16] --- 检查密码 [6 16] 数字和字符组成
    ///
    /// - Returns: Bool
    func isPassword() -> Bool {
        var regex = "^.*?[\\d]+.*$"
        let isMatch = matchRegular(regex)
        if !isMatch {
            return false
        }
        
        regex = ".*?[A-Za-z].*$"
        let isNumberMatch = matchRegular(regex)
        if !isNumberMatch {
            return false
        }
        regex = "^.{6,16}$"
        let lengthLimit = matchRegular(regex)
        if !lengthLimit {
            return false
        }
        return true
    }
    
    /// Check phone six message code --- 检查手机验证码(6位数字)
    ///
    /// - Returns: Bool
    public func isCode() -> Bool {
        guard !self .isEmpty else {
            return false
        }
        let regex = "^[0-9]{6}$"
        return matchRegular(regex)
    }
    
    /// Check email --- 检查邮箱
    ///
    /// - Returns: Bool
    public func isEmail() -> Bool {
        let regex = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
        return matchRegular(regex)
    }
    
    /// Check phone number --- 检查手机号
    ///
    /// - Returns: Bool
    public func isPhone() -> Bool {
        let regex = "^((10[0-9])|(11[0-9])|(12[0-9])|(13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$"
        return matchRegular(regex)
    }
    
    /// Check number --- 检查数字
    ///
    /// - Returns: Bool
    func isNumberString() -> Bool {
        guard !self.isEmpty else { return false }
        let regularExpression = "^[0-9]*$"
        return matchRegular(regularExpression)
    }
    
    /// Check only Chinese --- 检查是否纯中文
    ///
    /// - Returns: Bool
    public func validateChineseOnly() -> Bool {
        let regex = "^[\\u4e00-\\u9fa5]+$"
        return matchRegular(regex)
    }
    
    /// Check Chinese or Letter --- 检查是否中文、字母
    ///
    /// - Returns: Bool
    public func validateChineseOrLetter() -> Bool {
        let regex = "^[a-zA-Z\\u4e00-\\u9fa5]+$"
        return matchRegular(regex)
    }
    
    /// Check ID card --- 检查身份证号
    ///
    /// - Returns: Bool
    public func isIDCard() -> Bool {
        //判断位数
        if self.count != 15 && self.count != 18 {
            return false
        }
        var carid = self
        
        var lSumQT = 0
        
        //加权因子
        let R = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        
        //校验码
        let sChecker: [Int8] = [49, 48, 88, 57, 56, 55, 54, 53, 52, 51, 50]
        
        //将15位身份证号转换成18位
        let mString = NSMutableString(string: self)
        
        if self.count == 15 {
            mString.insert("19", at: 6)
            var p = 0
            let pid = mString.utf8String
            for i in 0...16 {
                let t = Int(pid![i])
                p += (t - 48) * R[i]
            }
            let o = p % 11
            let stringContent = NSString(format: "%c", sChecker[o])
            mString.insert(stringContent as String, at: mString.length)
            carid = mString as String
        }
        
        let cStartIndex = carid.startIndex
        let cEndIndex = carid.endIndex
        let index = carid.index(cStartIndex, offsetBy: 2)
        //判断地区码
        let sProvince = String(carid[cStartIndex..<index])
        if (!self.areaCodeAt(sProvince)) {
            return false
        }
        
        //判断年月日是否有效
        //年份
        let yStartIndex = carid.index(cStartIndex, offsetBy: 6)
        let yEndIndex = carid.index(yStartIndex, offsetBy: 4)
        let strYear = Int(carid[yStartIndex..<yEndIndex])
        
        //月份
        let mStartIndex = carid.index(yEndIndex, offsetBy: 0)
        let mEndIndex = carid.index(mStartIndex, offsetBy: 2)
        let strMonth = Int(carid[mStartIndex..<mEndIndex])
        
        //日
        let dStartIndex = carid.index(mEndIndex, offsetBy: 0)
        let dEndIndex = carid.index(dStartIndex, offsetBy: 2)
        let strDay = Int(carid[dStartIndex..<dEndIndex])
        
        let localZone = NSTimeZone.local
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.timeZone = localZone
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: "\(String(format: "%02d",strYear!))-\(String(format: "%02d",strMonth!))-\(String(format: "%02d",strDay!)) 12:01:01")
        
        if date == nil {
            return false
        }
        let paperId = carid.utf8CString
        //检验长度
        if 18 != carid.count {
            return false
        }
        //校验数字
        func isDigit(c: Int) -> Bool {
            return 0 <= c && c <= 9
        }
        for i in 0...18 {
            let id = Int(paperId[i])
            if isDigit(c: id) && !(88 == id || 120 == id) && 17 == i {
                return false
            }
        }
        //验证最末的校验码
        for i in 0...16 {
            let v = Int(paperId[i])
            lSumQT += (v - 48) * R[i]
        }
        if sChecker[lSumQT%11] != paperId[17] {
            return false
        }
        return true
    }
    
    fileprivate func areaCodeAt(_ code: String) -> Bool {
        var dic: [String: String] = [:]
        dic["11"] = "北京"
        dic["12"] = "天津"
        dic["13"] = "河北"
        dic["14"] = "山西"
        dic["15"] = "内蒙古"
        dic["21"] = "辽宁"
        dic["22"] = "吉林"
        dic["23"] = "黑龙江"
        dic["31"] = "上海"
        dic["32"] = "江苏"
        dic["33"] = "浙江"
        dic["34"] = "安徽"
        dic["35"] = "福建"
        dic["36"] = "江西"
        dic["37"] = "山东"
        dic["41"] = "河南"
        dic["42"] = "湖北"
        dic["43"] = "湖南"
        dic["44"] = "广东"
        dic["45"] = "广西"
        dic["46"] = "海南"
        dic["50"] = "重庆"
        dic["51"] = "四川"
        dic["52"] = "贵州"
        dic["53"] = "云南"
        dic["54"] = "西藏"
        dic["61"] = "陕西"
        dic["62"] = "甘肃"
        dic["63"] = "青海"
        dic["64"] = "宁夏"
        dic["65"] = "新疆"
        dic["71"] = "台湾"
        dic["81"] = "香港"
        dic["82"] = "澳门"
        dic["91"] = "国外"
        if (dic[code] == nil) {
            return false;
        }
        return true;
    }
}
