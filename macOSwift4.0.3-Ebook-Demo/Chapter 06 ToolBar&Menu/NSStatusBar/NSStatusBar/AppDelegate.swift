//
//  AppDelegate.swift
//  NSStatusBar
//
//  Created by iDevFans on 16/7/9.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem : NSStatusItem? = nil
    @IBOutlet weak var shareMenu: NSMenu!
    
    var isShow = false
    
    lazy var popover: NSPopover  = {
        
        let popoverTemp = NSPopover()
    
        popoverTemp.contentViewController = AppViewController()
        
        return popoverTemp
    
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
       
        // self.createButtonStatusBar()
    
        //self.createMenuStatusBar()
        
        self.createButtonStatusBarForPopover()
    }
    
    func createButtonStatusBar() {
        
        //获取系统单例NSStatusBar对象
        let statusBar = NSStatusBar.system
        //创建固定宽度的NSStatusItem
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.target = self
        item.button?.action = #selector(AppDelegate.itemAction(_:))
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "blue"))
        
        statusItem = item
    }
    
    
    func createButtonStatusBarForPopover() {
        
        //获取系统单例NSStatusBar对象
        let statusBar = NSStatusBar.system
        //创建固定宽度的NSStatusItem
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.target = self
        item.button?.action = #selector(AppDelegate.itemPopoverAction(_:))
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "blue"))
        
        statusItem = item
    }
    
    
    func createMenuStatusBar() {
        
        //获取系统单例NSStatusBar对象
        let statusBar = NSStatusBar.system
        //创建固定宽度的NSStatusItem
        let item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.image = NSImage(named: NSImage.Name(rawValue: "blue"))
        item.menu = self.shareMenu
        
        statusItem = item
    }
    
    
    
    
    @IBAction func itemAction(_ sender: AnyObject){
        //激活应用到前台(如果应用窗口处于非活动状态)
        NSRunningApplication.current.activate(options: [NSApplication.ActivationOptions.activateIgnoringOtherApps])
        let window =  NSApp.windows[0]
        window.orderFront(self)
    }
    
    @IBAction func shareAction(_ sender: AnyObject){
        print("shareAction")
    }
    

    
    @IBAction func itemPopoverAction(_ sender: NSStatusBarButton){
        if !self.isShow {
            self.isShow = true
            self.popover.show(relativeTo: NSZeroRect, of: sender, preferredEdge: .minY)
        }
        else {
            self.popover.close()
            self.isShow = false
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        let statusBar = NSStatusBar.system
        //应用退出时删除item
        statusBar.removeStatusItem(statusItem!)
    }
}


