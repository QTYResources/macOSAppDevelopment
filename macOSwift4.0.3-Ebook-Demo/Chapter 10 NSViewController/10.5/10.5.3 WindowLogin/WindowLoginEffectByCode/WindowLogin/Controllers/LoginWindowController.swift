//
//  LoginWindowController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/2.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController, NSWindowDelegate {
  
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func windowWillClose(_ notification: Notification) {
        self.contentViewController = nil
        self.window = nil
    }
}


