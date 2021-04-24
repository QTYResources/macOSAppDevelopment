//
//  LoginWindowController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/2.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController, NSWindowDelegate {
    
    lazy var windowBorderless: WindowBorderless = {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style : NSWindow.StyleMask = [NSWindow.StyleMask.borderless]
        //创建window
        let window  = WindowBorderless(contentRect:frame, styleMask:style, backing:.retained, defer:true)
        window.windowController = self
        window.delegate = self
        return window
    }()
    
    override init(window: NSWindow?) {
        super.init(window: windowBorderless)
        self.contentViewController = LoginViewController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func windowWillClose(_ notification: Notification) {
        self.contentViewController = nil
        self.window = nil
    }
}


