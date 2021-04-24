//
//  AppDelegate.swift
//  CloudKitDemo
//
//  Created by iDevFans on 16/8/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import CloudKit



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //远程消息注册
        NSApplication.shared.registerForRemoteNotifications(matching: [NSApplication.RemoteNotificationType.badge,NSApplication.RemoteNotificationType.alert,NSApplication.RemoteNotificationType.sound])
        
        self.createSubscription()
    }

    
    func application(_ application: NSApplication, didReceiveRemoteNotification userInfo: [String : Any]) {
        print("userInfo       \(userInfo)")
        
        let userInfoDic = userInfo as! [String : NSObject]
        
        let cloudKitNotification = CKNotification(fromRemoteNotificationDictionary: userInfoDic)
        
        if cloudKitNotification.notificationType == .query {
            let queryNotification = cloudKitNotification as! CKQueryNotification
            let recordID = queryNotification.recordID
            print("didReceiveRemoteNotification recordID \(recordID)")
        }
    }
    

    
    func createSubscription() {
        //定义订阅条件:当满足条件时 触发Push通知
        let predicate = NSPredicate(format: "name = %@", "Group2")
        let subscription = CKSubscription(recordType: "Members", predicate: predicate, options: [.firesOnRecordCreation,.firesOnRecordUpdate,.firesOnRecordDeletion])
        
        //定义推送消息:定义推送消息的title 和 appicon 上是否显示Badge
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertLocalizationKey = "New Member Joined!"
        notificationInfo.shouldBadge = true
        
        //配置消息通知订阅
        subscription.notificationInfo = notificationInfo
        
        //保存订阅到数据库
        let database = CKContainer.default().privateCloudDatabase
        database.save(subscription, completionHandler: {
            
            subscription,error in
            
            if error != nil {
                print("subscription error \(error)")
            }
        })
    }

}

func createSubscription() {
    //定义订阅条件:当满足条件时 触发Push通知
    let predicate = NSPredicate(format: "name = %@", "Group2")
    let subscription = CKSubscription(recordType: "Members", predicate: predicate, options: [.firesOnRecordCreation,.firesOnRecordUpdate,.firesOnRecordDeletion])
    
    //定义推送消息:定义推送消息的title 和 appicon 上是否显示Badge
    let notificationInfo = CKNotificationInfo()
    notificationInfo.alertLocalizationKey = "New Member Joined!"
    notificationInfo.shouldBadge = true
    
    //配置消息通知订阅
    subscription.notificationInfo = notificationInfo
    
    //保存订阅到数据库，有变化时发送通知
    let database = CKContainer.default().privateCloudDatabase
    database.save(subscription, completionHandler: {
        
        subscription,error in
        
        if error != nil {
            print("subscription error \(error)")
        }
    })
}


