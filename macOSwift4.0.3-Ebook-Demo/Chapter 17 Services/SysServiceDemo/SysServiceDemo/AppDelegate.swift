//
//  AppDelegate.swift
//  SysServiceDemo
//
//  Created by iDevFans on 16/7/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let s = ServiceProvider()
        NSApp.servicesProvider = s
        NSUpdateDynamicServices()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    let s = ServiceProvider()
    NSApp.servicesProvider = s
    NSUpdateDynamicServices()
}

