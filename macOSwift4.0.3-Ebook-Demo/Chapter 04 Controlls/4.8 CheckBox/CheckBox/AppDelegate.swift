//
//  AppDelegate.swift
//  CheckBox
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var onButton: NSButton!
    @IBOutlet weak var offButton: NSButton!
    @IBOutlet weak var mixedButton: NSButton!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        onButton.state = .on
        offButton.state = .off
        mixedButton.state = .mixed
        
        mixedButton.allowsMixedState = true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    @IBAction func checkBtnClicker(_ sender: NSButton){
        let state = sender.state
        if state == .on {
            print("check selected ")
        }
        else {
             print("check un selected ")
        }
        print("state :\(state)")
    }

}



