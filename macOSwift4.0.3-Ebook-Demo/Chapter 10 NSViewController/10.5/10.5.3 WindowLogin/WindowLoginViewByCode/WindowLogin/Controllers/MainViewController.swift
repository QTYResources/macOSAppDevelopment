//
//  MainViewController.swift
//  WindowLogin
//
//  Created by zhaojw on 2017/11/5.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.isRestorable = false
        self.view.window?.center()
    }
    
    override func loadView() {
        let frame = CGRect(x: 0, y: 0, width: 600, height: 320)
        let view = NSView(frame: frame)
        self.view = view
    }
    
}
