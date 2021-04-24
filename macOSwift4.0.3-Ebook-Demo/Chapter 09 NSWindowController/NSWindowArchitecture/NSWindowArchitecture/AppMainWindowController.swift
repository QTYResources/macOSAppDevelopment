//
//  AppMainWindowController.swift
//  NSWindowArchitecture
//
//  Created by iDevFans on 16/7/13.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class AppMainWindowController: NSWindowController {

    lazy var viewController: AppViewController = {
       let vc = AppViewController()
       return vc
    }()
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.contentViewController = self.viewController
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    
    //返回window的xib文件名
    override var windowNibName: NSNib.Name? { return NSNib.Name("AppMainWindowController") }
}
