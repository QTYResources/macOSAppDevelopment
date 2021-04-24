//
//  WindowController.swift
//  PureCodeApp
//
//  Created by iDevFans on 16/10/15.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    lazy var myWindow: NSWindow = {
        let frame = CGRect(x: 0, y: 0, width: 400, height: 280)
        let style : NSWindow.StyleMask = [NSWindow.StyleMask.titled,NSWindow.StyleMask.closable,NSWindow.StyleMask.resizable]
        //创建window
        let window = NSWindow(contentRect:frame, styleMask:style, backing:.buffered, defer:false)
        window.isRestorable = false
        window.title = "Code Create Window"
        window.windowController = self
        return window
    }()
   

    lazy var vc: NSViewController = {
        let viewController  = ViewController()
        return viewController
    }()
    
    
    convenience init(windowNibName: NSNib.Name){
        self.init(window:nil)
    }
    
    override init(window: NSWindow?){
        super.init(window:window)
        self.window = self.myWindow
        self.contentViewController = self.vc
        self.window?.center()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
