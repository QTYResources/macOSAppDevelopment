//
//  AppDelegate.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var timer: Timer?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.buddyTest), userInfo: nil, repeats: true)
        
    }

    @objc func buddyTest() {
        let ID = arc4random() % 2 + 1
        let status = arc4random() % 10
        let buddy = BuddyList()
        buddy.ID = Int(ID)
        buddy.status = false
        if status > 5 {
            buddy.status = true
            BuddyStatusManager.shared.multiDelegate.buddyOnlineRequest(buddy)
        }
        else{
            BuddyStatusManager.shared.multiDelegate.buddyOfflineRequest(buddy)
        }
    }

}

