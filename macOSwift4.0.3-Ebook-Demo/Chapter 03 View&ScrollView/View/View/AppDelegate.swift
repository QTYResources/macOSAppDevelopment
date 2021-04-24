//
//  AppDelegate.swift
//  View
//
//  Created by iDevFans on 16/6/25.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var customView: CustomView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let button = NSButton()

        let frame = NSRect(x: 2, y: 2, width: 80, height: 18)
        button.frame = frame
        button.title = "Register"
        button.bezelStyle = .rounded
        
        self.customView.addSubview(button)
        self.customView.postsFrameChangedNotifications = true
        
       
    }
    
    func registerNotification() {
         NotificationCenter.default.addObserver(self, selector:#selector(self.recieveFrameChangeNotification(_:)),  name:NSView.frameDidChangeNotification, object: nil)
    }

    
    @objc func recieveFrameChangeNotification(_ notification: Notification){
        
    }
    
    @IBAction func captureAction(_ sender: NSButton) {
        self.customView.saveSelfAsImage()
    }
}



