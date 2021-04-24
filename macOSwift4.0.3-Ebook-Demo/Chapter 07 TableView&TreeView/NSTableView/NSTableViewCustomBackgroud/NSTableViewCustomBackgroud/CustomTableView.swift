//
//  CustomTableView.swift
//  NSTableViewCustomBackgroud
//
//  Created by iDevFans on 16/10/17.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CustomTableView: NSTableView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func drawBackground(inClipRect clipRect: NSRect) {
        NSColor.gray.set()
        NSRectFill(clipRect)
    }
    
}
