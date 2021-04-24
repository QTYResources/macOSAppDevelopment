//
//  AppDelegate.swift
//  NSPanel
//
//  Created by iDevFans on 16/7/7.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var loginPanel: NSPanel!

    @IBOutlet weak var userNameField: NSTextField!

    @IBOutlet weak var passwordField: NSTextField!
 
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: Action 
    
    @IBAction func loginButtonAction(_ sender: NSButton) {
        
        self.window.beginSheet(self.loginPanel, completionHandler: { [weak self] returnCode in
            
            let userName = self?.userNameField.stringValue
            let password = self?.passwordField.stringValue
            
            print("returnCode \(returnCode)")
            
        })
    }
    
    @IBAction func okButtonAction(_ sender: NSButton) {
        self.window.endSheet(self.loginPanel)
    }
}




