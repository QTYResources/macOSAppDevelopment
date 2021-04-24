//
//  AppDelegate.swift
//  PushNotification
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

NSApplication.shared.registerForRemoteNotifications(matching: [NSApplication.RemoteNotificationType.badge,NSApplication.RemoteNotificationType.alert,NSApplication.RemoteNotificationType.sound])



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //远程消息注册
        NSApplication.shared.registerForRemoteNotifications(matching: [NSApplication.RemoteNotificationType.badge,NSApplication.RemoteNotificationType.alert,NSApplication.RemoteNotificationType.sound])
        
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func application(_ application: NSApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        var tokenStr = ""
        for i in 0..<deviceToken.count {
            tokenStr = tokenStr + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        
        print("deviceToken Data: \(tokenStr)")

    }
 
    func application(_ application: NSApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("RegisterForRemoteNotifications       \(error)")
    }
    
    func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String : Any]) {
        print("userInfo       \(userInfo)")
    }
}




