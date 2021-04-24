//
//  AppDelegate.swift
//  NSButton
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.createButton()
    }

    @IBAction func buttonClicked(_ sender: NSButton) {
        print("buttonClicked")
    }
    
    func createButton(){
        let frame = CGRect(x: 0, y: 0, width: 100, height: 28)
        let btn = NSButton(frame: frame)
        btn.bezelStyle = .rounded
        btn.title  = "CodeButton"
        btn.target = self
        btn.action = #selector(buttonClicked(_:))
        self.window.contentView?.addSubview(btn)
    }

}





