//
//  AppDelegate.swift
//  RunLoop
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let f = "12312"
        
        let aRect = NSMakeRect(10.0, 10.0, 40.0, 40.0)
        let thePath = NSBezierPath()
        thePath.appendRect(aRect)
        thePath.stroke()
        NSBezierPath.stroke(aRect)
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

