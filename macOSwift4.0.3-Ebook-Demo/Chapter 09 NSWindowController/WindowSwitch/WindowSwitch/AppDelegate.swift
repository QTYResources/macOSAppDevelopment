//
//  AppDelegate.swift
//  WindowSwitch
//
//  Created by iDevFans on 16/8/22.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var loginWVC: NSWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        
        loginWVC = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "LoginWVC")) as? NSWindowController
        
        loginWVC?.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

