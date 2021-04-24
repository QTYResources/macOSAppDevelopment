//
//  NSSplitView.swift
//  NSSplitView
//
//  Created by zhaojw on 2017/10/22.
//  Copyright © 2017年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class SplitView: NSSplitView {
    override var dividerColor: NSColor {
        return NSColor.gray
    }
    
    override func drawDivider(in rect: NSRect) {
        let dividerRect = rect.insetBy(dx: 0.3, dy: 0.3)
        let path = NSBezierPath(rect: dividerRect)
        dividerColor.setFill()
        path.fill()
    }
}
