//
//  CustomTableRowView.swift
//  CustomTableView
//
//  Created by iDevFans on 16/10/17.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CustomTableRowView: NSTableRowView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    override func drawSeparator(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            NSColor.black.setStroke()
            NSColor.black.setFill()
            let selectionPath = NSBezierPath(rect: dirtyRect)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
    
    override func drawBackground(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            NSColor.blue.setStroke()
            NSColor.yellow.setFill()
            let selectionPath = NSBezierPath(rect: dirtyRect)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let selectionRect = NSInsetRect(self.bounds, 1, 1)
            NSColor(calibratedWhite: 0.9, alpha: 1).setStroke()
            NSColor.red.setFill()
            let selectionPath = NSBezierPath(rect: selectionRect)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
}
