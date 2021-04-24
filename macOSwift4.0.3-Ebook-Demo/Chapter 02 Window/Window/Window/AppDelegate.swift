//
//  AppDelegate.swift
//  Window
//
//  Created by iDevFans on 16/6/24.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa
import AppKit



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var modalWindow: NSWindow!
    
    var myWindow: NSWindow!
    
    var sessionCode : NSApplication.ModalSession?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NotificationCenter.default.addObserver(self, selector:#selector(self.windowClose(_:)),  name: NSWindow.willCloseNotification, object: nil)
        
        self.setWindowTitleImage()
        
        //self.setWindowBKColor()
        
        self.addButtonToTitleBar()
        
        
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        NotificationCenter.default.removeObserver(self)
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    
    @IBAction func showModalWindow(_ sender: NSButton) {
        NSApplication.shared.runModal(for: self.modalWindow)
        self.modalWindow.center()
    }
    
    
    
    @IBAction func showSessionsWindow(_ sender: NSButton) {
        sessionCode = NSApplication.shared.beginModalSession(for: self.modalWindow)
    }
    
   

    @objc func windowClose(_ aNotification: Notification){
        
        if let sessionCode = sessionCode {
            NSApplication.shared.endModalSession(sessionCode)
            self.sessionCode = nil
        }
        
        if let window = aNotification.object as? NSWindow {
            if self.modalWindow == window {
                NSApplication.shared.stopModal()
            }
            if window == self.window! {
                NSApp.terminate(self)
            }
        }
        
    }
    
    @IBAction func createWindowAction(_ sender: NSButton) {
        self.createWindow()
    }
    
    
    
    func createWindow() {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style : NSWindow.StyleMask = [NSWindow.StyleMask.titled,NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable]
        //创建window
        myWindow = NSWindow(contentRect:frame, styleMask:style, backing:.buffered, defer:false)
        myWindow.title = "New Create Window"
        //显示window
        myWindow.makeKeyAndOrderFront(self);
        //居中
        myWindow.center()
    }
    
    
    func setWindowTitleImage(){
        self.window.representedURL = URL(string:"WindowTitle")
        self.window.title = "My Window"
        let image = NSImage(named: NSImage.Name(rawValue: "AppIcon.png"))
        self.window.standardWindowButton(.documentIconButton)?.image = image
    }
    
    
    func setWindowBKColor(){
        self.window.backgroundColor = NSColor.green
    }
    
    
    func addButtonToTitleBar(){
        let titleView = self.window.standardWindowButton(.closeButton)?.superview
        let button = NSButton()
        let x = (self.window.contentView?.frame.size.width)! - 100
        let frame = CGRect(x: x, y: 0, width: 80, height: 24)
        button.frame = frame
        button.title = "Register"
        button.bezelStyle = .rounded
        titleView?.addSubview(button)
    }

}





