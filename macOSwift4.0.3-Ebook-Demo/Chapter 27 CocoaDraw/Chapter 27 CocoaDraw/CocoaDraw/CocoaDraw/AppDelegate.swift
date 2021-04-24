//
//  AppDelegate.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func drawBorder(frame: NSRect) {
        var remainderRect = NSZeroRect
        var borderRects = [NSZeroRect,NSZeroRect]
        
        NSDivideRect(frame, &borderRects[0], &remainderRect, 0.5, .minY)
        NSDivideRect(frame, &borderRects[1], &remainderRect, 0.5, .maxY)
        
        NSColor.lightGray.setFill()
        NSColor.lightGray.setStroke()
        NSRectFillList(borderRects, 2)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

