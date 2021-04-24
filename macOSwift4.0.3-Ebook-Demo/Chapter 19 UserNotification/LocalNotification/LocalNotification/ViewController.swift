//
//  ViewController.swift
//  LocalNotification
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLocalNotification()
        // Do any additional setup after loading the view.
    }

    func startLocalNotification() {
        let notification = NSUserNotification()
        //消息标题
        notification.title = "Message"
        
        notification.hasReplyButton = true
        notification.hasActionButton = true
        notification.otherButtonTitle = "Reply"
        notification.contentImage = NSImage(named: NSImage.Name(rawValue: "Menu"))
        
        //消息详细信息
        notification.informativeText = "I have a dream!"
        //消息附加数据
        notification.userInfo = ["messageID":1000]
        //注册的时间
        notification.deliveryDate = NSDate(timeIntervalSinceNow: 10) as Date
        //重复的间隔,5分钟一次
        notification.deliveryRepeatInterval?.minute = 1
        //设置代理
        NSUserNotificationCenter.default.delegate = self
        //注册本地推送
        NSUserNotificationCenter.default.scheduleNotification(notification)

    }
}



extension ViewController: NSUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        print("didDeliver notification \(notification)")
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        self.view.window?.orderFront(self)
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}



