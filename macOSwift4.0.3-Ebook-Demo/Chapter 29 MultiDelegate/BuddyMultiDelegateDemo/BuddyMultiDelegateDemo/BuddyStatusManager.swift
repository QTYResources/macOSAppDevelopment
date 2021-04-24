//
//  BuddyStatusManager.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

//代理协议
@objc protocol BuddyStatusDelegate  {
    @objc optional  func buddyOfflineRequest(sender: AnyObject,  buddy: BuddyList)
    @objc optional  func buddyOnlineRequest(sender: AnyObject,  buddy: BuddyList)
    @objc optional  func buddySelection(sender: AnyObject,  buddy: BuddyList)
}

//多代理广播接口
class BuddyStatusMulticastDelegate: GCDMulticastDelegate,BuddyStatusDelegate {
    
    func buddyOfflineRequest(_ buddy: BuddyList) {
        let multiDelegate: BuddyStatusDelegate = self
        multiDelegate.buddyOfflineRequest!(sender: self, buddy: buddy)
    }
    
    func buddyOnlineRequest(_ buddy: BuddyList) {
        let multiDelegate: BuddyStatusDelegate = self
        multiDelegate.buddyOnlineRequest!(sender: self, buddy: buddy)
    }
    
    func buddySelection(_ buddy: BuddyList) {
        let multiDelegate: BuddyStatusDelegate = self
        multiDelegate.buddySelection!(sender: self, buddy: buddy)
    }
}

//多代理管理类
class BuddyStatusManager: NSObject {
    
    lazy var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "macdec.io.BuddyManager")
        return queue
    }()
    
    private static let  sharedInstance = BuddyStatusManager()
    class var shared: BuddyStatusManager {
        return sharedInstance
    }
    
    lazy var multiDelegate: BuddyStatusMulticastDelegate = {
        let delegate = BuddyStatusMulticastDelegate()
        return delegate
    }()
    
    func addMultiDelegate(delegate:BuddyStatusDelegate, delegateQueue:DispatchQueue?){
        if delegateQueue == nil {
            multiDelegate.add(delegate, delegateQueue: self.queue)
        }
        else {
            multiDelegate.add(delegate, delegateQueue: delegateQueue)
        }
    }
    func removeMultiDelegate(delegate:BuddyStatusDelegate){
        multiDelegate.remove(delegate)
    }
}
