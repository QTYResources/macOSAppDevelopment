//
//  HeaderView.swift
//  NSCollectionViewHeadFoot
//
//  Created by zhaojw on 2017/10/22.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class HeaderView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.red.setFill()
        dirtyRect.fill()
        // Drawing code here.
    }
    
}
