//
//  AppDelegate.swift
//  NSSearchField
//
//  Created by iDevFans on 16/6/28.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var searchField: NSSearchField!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        self.registerSearchButtonAction()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func registerSearchButtonAction(){
        
        let searchButtonCell  = self.searchField.cell as! NSSearchFieldCell
        let searchButtonActionCell = searchButtonCell.searchButtonCell!
        
        searchButtonActionCell.target = self
        searchButtonActionCell.action = #selector(searchButtonAction(_:))
        
        let cancelButtonCell  = self.searchField.cell as! NSSearchFieldCell
        let cancelButtonActionCell = cancelButtonCell.cancelButtonCell!
        
        cancelButtonActionCell.target = self
        cancelButtonActionCell.action = #selector(cancelButtonAction(_:))
        
    }
    
    
    @IBAction func searchAction(_ sender: NSSearchField) {
        let text = sender.stringValue
        print("searchAction:\(text)")
        //实现搜索逻辑方法调用 刷新结果
    }

    
    @IBAction func searchButtonAction(_ sender: NSSearchField) {
        
        self.searchAction(sender)
    }
    
    @IBAction func cancelButtonAction(_ sender: NSSearchField) {
        
        sender.stringValue = ""
    }

}







