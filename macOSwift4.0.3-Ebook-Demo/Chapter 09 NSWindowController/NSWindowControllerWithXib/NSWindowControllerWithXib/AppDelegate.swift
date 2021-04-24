//
//  AppDelegate.swift
//  NSWindowControllerWithXib
//
//  Created by iDevFans on 16/7/13.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    lazy var myWindowController: NSWindowController = {
        let wondowVC = NSWindowController()
        return wondowVC
    }()

    lazy var myWindow: MyWindow = {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style : NSWindow.StyleMask = [NSWindow.StyleMask.titled,NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable]
        //创建window
        let window  = MyWindow(contentRect:frame, styleMask:style, backing:.retained, defer:true)
        //window.windowController = self.myWindowController
        //self.myWindowController.window = window;
        window.title = "New Create Window"
        return window
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func showWindowAction(_ sender:NSButton) {
        
        self.myWindow.makeKeyAndOrderFront(self);
        
        self.myWindow.center()
 
    }

}



