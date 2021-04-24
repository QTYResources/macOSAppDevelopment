//
//  LockFocusView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class LockFocusView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        self.wantsLayer = true
        self.layer?.borderWidth = 1
        
        let canvas = NSImage(size: dirtyRect.size)
        canvas.lockFocus()
        dirtyRect.fill()
        NSBezierPath.stroke(dirtyRect)
        canvas.unlockFocus()
       // canvas.draw(at: NSPoint(x: 0, y: 0), from: NSRect(x: 0, y: 0, width: 40, height: 40)
//, operation: .sourceOver, fraction: 1.0)
        
        
        let image = NSImage(size: dirtyRect.size, flipped: true, drawingHandler: {
           
            rect in
            
            NSColor.red.setFill()
            
            rect.fill()
            
            return true
        
        })
        
        image.draw(at: NSPoint(x: 0, y: 0), from: NSRect(x: 0, y: 0, width: 40, height: 40)
            , operation: .sourceOver, fraction: 1.0)
        
    }
    
}



