//
//  UITableView+Nib.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/14.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

protocol LJUIViewReusable {
    static var className: String { get }
}

extension LJUIViewReusable {
    static var className: String {
        return String(describing: self)
    }
}

extension UIView: LJUIViewReusable {}

extension UITableView {
    /// Register cell use class name as indentifier --- 注册 Cell, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    public func registerCell<T: UIView>(cls: T.Type) {
        self.register(cls, forCellReuseIdentifier: T.className)
    }
    
    /// Register cell use xib and class name as indentifier --- 用 xib 注册 Cell, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerCellFromNib<T: UIView>(cls: T.Type) {
        self.register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
    
    /// Register cell use xib --- 用 xib 注册 Cell
    ///
    /// - Parameters:
    ///   - cls: UIView
    ///   - identifier: String
    func registerCellFromNib<T: UIView>(cls: T.Type, identifier: String) {
        self.register(UINib.init(nibName: T.className, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    /// Register Header Footer use class name as indentifier --- 注册头和尾视图, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerHeaderFooter<T: UIView>(cls: T.Type) {
        self.register(cls, forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    /// Register Header Footer use xib and class name as indentifier --- 用 xib 注册头和尾视图, 名称作为 indentifier
    ///
    /// - Parameter cls: UIView
    func registerHeaderFooterFromNib<T: UIView>(cls: T.Type) {
        self.register(UINib.init(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    /// DequeueReuse cell --- 重用 cell
    ///
    /// - Parameters:
    ///   - cls: UIView
    ///   - indexPath: IndexPath
    /// - Returns: UIView
    func dequeueReuseCell<T: UIView>(_ cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Can't dequeue reuseable cell with identifier = \(T.className)")
        }
        return cell
    }
    
    /// DequeueReuse header and footer --- 重用头和尾视图
    ///
    /// - Parameter cls: UIView
    /// - Returns: UIView
    func dequeueHeaderFooter<T: UIView>(_ cls: T.Type) -> T {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("Can't dequeue reuseable HeaderFooterView with identifier = \(T.className)")
        }
        return view
    }
}

extension UIView {
    /// Load view from nib --- 从 xib 加载视图
    ///
    /// - Returns: UIView
    public class func loadNib() -> UIView {
        let nibName = String(describing: self)
        guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? UIView else {
            fatalError("Can't load nib with name = \(nibName)")
        }
        return view
    }
}
