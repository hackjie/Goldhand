//
//  Bool+toggle.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/10/27.
//  Copyright © 2018年 李杰. All rights reserved.
//

extension Bool {
    /// Toggle Bool value --- 切换 Bool 值
    mutating func toggle() {
        self = !self
    }
}
