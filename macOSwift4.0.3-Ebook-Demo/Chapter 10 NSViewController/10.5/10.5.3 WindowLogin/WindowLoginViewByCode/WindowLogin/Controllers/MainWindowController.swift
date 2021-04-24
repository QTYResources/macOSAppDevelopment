//
//  MainWindowController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/3.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
    lazy var windowInstence: NSWindow = {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        let style : NSWindow.StyleMask = [NSWindow.StyleMask.titled,NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable,NSWindow.StyleMask.miniaturizable]
        //创建window
        let window  = NSWindow(contentRect:frame, styleMask:style, backing:.retained, defer:true)
        window.title = "Main Window"
        window.windowController = self
        window.delegate = self
        return window
    }()
    
    override init(window: NSWindow?) {
        super.init(window: windowInstence)
        self.contentViewController = MainViewController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func windowWillClose(_ notification: Notification) {
        self.contentViewController = nil
        self.window = nil
    }
}
