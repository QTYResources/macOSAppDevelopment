//
//  CustomTextView.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CustomTextView: NSView {

    var string:NSMutableString =  NSMutableString()
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        self.wantsLayer = true
        self.layer?.borderWidth = 1
        self.layer?.borderColor = NSColor.gray.cgColor
        
        if string.length > 0 {
           string.draw(in: dirtyRect, withAttributes: [:])
        }
    }

    
    override func keyDown(with event: NSEvent) {
        self.interpretKeyEvents([event])
    }
    
    override func insertText(_ insertString: Any) {
        string.append(insertString as! String)
        NSLog("insertString \(string)");
        self.needsDisplay = true
    }
    
    
    override func moveUp(_ sender: Any?) {
        NSLog("moveUp")
    }
    override func moveDown(_ sender: Any?) {
        NSLog("moveDown")
    }
    override func moveLeft(_ sender: Any?) {
        NSLog("moveLeft")
    }
    override func moveRight(_ sender: Any?) {
        NSLog("moveRight")
    }
    
    override func insertNewline(_ sender: Any?) {
        NSLog("insertNewline")
    }
    override func deleteBackward(_ sender: Any?) {
        NSLog("deleteBackward")
    }
    
    
    override var acceptsFirstResponder: Bool {
        return true
    }
    
}
