//
//  Window.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/21.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class Window: NSWindow {
    
    override func sendEvent(_ event: NSEvent) {
        NSLog("sendEvent \(event)")
        //对event做统计处理，内部转发处理
        super.sendEvent(event)
    }
    
    override func postEvent(_ event: NSEvent, atStart flag: Bool) {
         NSLog("sendEvent \(event)")
         super.postEvent(event,atStart:flag)
    }
}



