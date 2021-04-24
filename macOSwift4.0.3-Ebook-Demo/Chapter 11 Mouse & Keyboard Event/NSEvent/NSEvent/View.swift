//
//  View.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/21.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class View: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.blue.setFill()
        let frame = self.bounds
        let path = NSBezierPath()
        path .appendRoundedRect(frame, xRadius: 20, yRadius: 20)
        path.fill()
    }
    
    override func mouseDown(with event: NSEvent) {
        //获取鼠标点击位置坐标
        let eventLocation = event.locationInWindow
        
        //转化成视图的本地坐标
        let pointInView   = self.convert(eventLocation, to: nil)
        
        //逻辑处理代码
        
        //如果同时按下了command键
        if event.modifierFlags.contains(NSEvent.ModifierFlags.command) {
            self.wantsLayer = true
            self.layer?.borderColor = NSColor.gray.cgColor
            self.layer?.borderWidth = 10
        }
        
        //判定是否鼠标双击事件
        if event.clickCount>=2 {
            NSLog("mouse  double click event ")
        }
        else {
            super.mouseDown(with: event)
        }
        
    }
    
    
    
    
    override func keyDown(with event: NSEvent) {
       
        NSLog("keyDown \(event.characters) modifierFlags = \(event.modifierFlags)")
        
        if event.modifierFlags.contains(NSEvent.ModifierFlags.command) {
            
            NSLog("modifierFlags \(event.modifierFlags)")
        }
        
        super.keyDown(with: event)
        
    }
    
    
    
    
    
    override func doCommand(by selector: Selector) {
        
        let event = self.window?.currentEvent
        
        NSLog("doCommand modifierFlags \(event?.modifierFlags)")
        
        
    }
    
            override var canBecomeKeyView: Bool {
               return false
            }
    
            override var acceptsFirstResponder: Bool {
                return true
            }
    
    
            override func becomeFirstResponder() -> Bool {
                
                return true
            }
    
            override func resignFirstResponder() -> Bool {
                return true
            }
    
    
    

    
}





