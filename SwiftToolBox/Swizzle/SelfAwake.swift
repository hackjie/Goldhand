//
//  SelfAwake.swift
//  SwiftToolBox
//
//  Created by 李杰 on 2018/11/11.
//  Copyright © 2018年 李杰. All rights reserved.
//

import UIKit

protocol SelfAwake {
    static func awake()
}

class SendMsgToClassImpleSelfAwake {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAwake.Type)?.awake()
        }
        types.deallocate()
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        SendMsgToClassImpleSelfAwake.harmlessFunction()
    }()

    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}
