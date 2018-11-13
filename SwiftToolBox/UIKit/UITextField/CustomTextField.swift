//
//  CustomTextField.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/13.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

/// 1. 设置光标高度

/// 2. placeholder 的字体 和 输入文字后的字体 不一样
/// 发现使用 KVC 的方式设置 _placeholderLabel.font 或者 placeholderAttributeText 在 iOS 9 是不起作用的
/// 正确的方法是 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool 和 func textFieldShouldClear(_ textField: UITextField) -> Bool
/// 设置字体

class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 问题1
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originRect = super.caretRect(for: position)
        originRect.origin.y = 0
        originRect.size.height = 40
        originRect.size.width = 2
        self.setValue(UIFont.systemFont(ofSize: 20), forKeyPath: "_placeholder.Label")
        return originRect
    }

}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        /// 问题2
        if text.count + (string.count - range.length) > 0 {
            textField.font = UIFont.systemFont(ofSize: 36)
        } else {
            textField.font = UIFont.systemFont(ofSize: 20)
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        /// 问题2
        textField.font = UIFont.systemFont(ofSize: 20)
        return true
    }
}
