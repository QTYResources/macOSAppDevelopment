//
//  AppDelegate.swift
//  PureCodeStoryboard
//
//  Created by iDevFans on 16/10/15.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var wc: WindowController = {
        let wc = WindowController()
        return wc
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.wc.showWindow(self)
    }
}

