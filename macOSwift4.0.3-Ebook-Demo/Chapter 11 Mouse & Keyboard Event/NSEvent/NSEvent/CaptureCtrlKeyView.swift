//
//  CaptureCtrlKeyView.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CaptureCtrlKeyView: NSImageView {

    override func keyDown(with event: NSEvent) {
        
        NSLog("keyDown \(event.characters) modifierFlags = \(event.modifierFlags)")
        
        //单个功能键按下判断
        if event.modifierFlags.contains(NSEvent.ModifierFlags.command) {
            
            NSLog("modifierFlags command")
        }
        
        if event.modifierFlags.contains(NSEvent.ModifierFlags.shift) {
            
            NSLog("modifierFlags shift")
        }
        
        if event.modifierFlags.contains(NSEvent.ModifierFlags.control) {
            
            NSLog("modifierFlags shift")
        }
        
        //组合按键到判断
        //是否同时按下
        if event.modifierFlags.contains(NSEvent.ModifierFlags.command) &&  event.modifierFlags.contains(NSEvent.ModifierFlags.shift) {
            
        }
        
        //回车
        if event.keyCode == 36 {
            NSLog("return key pressed!")
        }
        //空格
        if event.keyCode == 49 {
            NSLog("space key pressed!")
        }
        //上箭头
        if event.keyCode == 126 {
            NSLog("Up Arrow key pressed!")
        }
        //下箭头
        if event.keyCode == 125 {
            NSLog("Down Arrow key pressed!")
        }
        //左箭头
        if event.keyCode == 123 {
            NSLog("Left Arrow key pressed!")
        }
        //右箭头
        if event.keyCode == 124 {
            NSLog("Right Arrow  key pressed!")
        }
        
        super.keyDown(with: event)
        
    }
    
    
}
