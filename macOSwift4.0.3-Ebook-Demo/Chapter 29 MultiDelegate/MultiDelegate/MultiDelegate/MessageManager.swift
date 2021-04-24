//
//  MessageManager.swift
//  MultiDelegate
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


class Message {
    var msgID: Int = 0
    var fromUID: Int = 0
    var toUID: Int = 0
    var content:  String?
}

protocol MessageDelegate: class {
    func recieveMessage(_ message: Message)
}

class MessageManager: NSObject {
    
    weak var delegate1: MessageDelegate?
    weak var delegate2: MessageDelegate?
    
    func recieveMessage(_ message: Message) {
        if let delegate = self.delegate1 {
            delegate.recieveMessage(message)
        }
        if let delegate = self.delegate2 {
            delegate.recieveMessage(message)
        }
    }
    
    func notifyMessage(_ message: Message) {
        NotificationCenter.default.post(name:Notification.Name.onChatMessage, object: message)
    }
}


extension Notification.Name {
    //定义消息通知名称
    static let onChatMessage  = Notification.Name("on-chat-message")
}



