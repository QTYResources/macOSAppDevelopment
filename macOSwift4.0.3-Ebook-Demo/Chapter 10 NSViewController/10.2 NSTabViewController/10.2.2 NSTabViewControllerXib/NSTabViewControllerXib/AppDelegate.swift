//
//  AppDelegate.swift
//  NSTabViewControllerXib
//
//  Created by iDevFans on 16/7/18.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let tabViewContrller    = TabViewContrller()
        
                
        self.window.contentViewController = tabViewContrller
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

