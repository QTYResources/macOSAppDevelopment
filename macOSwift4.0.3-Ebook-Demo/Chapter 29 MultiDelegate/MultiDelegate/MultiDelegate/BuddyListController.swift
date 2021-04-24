//
//  BuddyListController.swift
//  MultiDelegate
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class BuddyListController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNotification()
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.onRecieveChatMessage(_:)),  name:NSNotification.Name.onChatMessage, object: nil)
        
    }
    
    @objc func onRecieveChatMessage(_ notification: Notification){
        let message = notification.object as! Message
        print("\(message.content)")
    }
}
