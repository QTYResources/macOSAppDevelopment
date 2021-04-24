//
//  AppDelegate.swift
//  TableViewControllerDemo
//
//  Created by iDevFans on 16/8/19.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var windowController: WindowController = {
        let windowVC = WindowController()
        return windowVC
    }()


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        //self.windowController.showWindow(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

