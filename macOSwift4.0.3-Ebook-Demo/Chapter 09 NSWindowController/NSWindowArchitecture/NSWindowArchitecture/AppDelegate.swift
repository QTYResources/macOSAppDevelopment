//
//  AppDelegate.swift
//  NSWindowArchitecture
//
//  Created by iDevFans on 16/7/13.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    lazy var windowController: AppMainWindowController = {
        let wondowVC = AppMainWindowController()
        return wondowVC
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        self.windowController.showWindow(self)
    }
}

