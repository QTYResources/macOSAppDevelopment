//
//  WindowController.swift
//  NSSplitViewCollapse
//
//  Created by iDevFans on 16/7/20.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

let kOpenCloseViewNotification = "OpenCloseViewNotification"

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func openCloseAction(_ sender: AnyObject) {
        NotificationCenter.default.post(name: Notification.Name.onOpenCloseView, object: nil)
    }
}

extension Notification.Name {
    //定义消息通知名称
    static let onOpenCloseView  = Notification.Name("on-open-close-view")
}

