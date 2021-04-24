//
//  AppDelegate.swift
//  ScrollView
//
//  Created by iDevFans on 16/6/25.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var datas = [NSDictionary]()
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var scrollView: NSScrollView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        addScrollView()
        
        addNoScrollerScrollView()
        
        updateData()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func addScrollView(){
        
        let frame = CGRect(x: 0, y: 0, width: 100, height:100)
        //let myScrollView = DisableVerticalScrollView(frame: frame)
        let myScrollView = NSScrollView(frame: frame)
        let image = NSImage(named: NSImage.Name(rawValue: "screen.png"))
        let imageViewFrame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height:  (image?.size.height)!)
        let imageView = NSImageView(frame: imageViewFrame)

        imageView.image = image
        
        myScrollView.hasVerticalScroller = true
        myScrollView.hasHorizontalScroller = true
        myScrollView.documentView = imageView
        
        //myScrollView.verticalLineScroll = 0.0
        //myScrollView.verticalPageScroll = 0.0
       
        //myScrollView.contentSize.height = 0

        self.window.contentView?.addSubview(myScrollView)
        
        let contentView2: NSClipView = myScrollView.contentView
        
        //return
        
        //滚动到顶部位置
        var newScrollOrigin : NSPoint
        let contentView: NSClipView = myScrollView.contentView
        
        if self.window.contentView!.isFlipped {
            newScrollOrigin = NSPoint(x: 0.0,y: 0.0);
        }
        else{
            newScrollOrigin = NSPoint(x: 0.0,y: imageView.frame.size.height-contentView.frame.size.height);
        }
        contentView.scroll(to: newScrollOrigin)
    }
    
     func addNoScrollerScrollView(){
        
        let frame = CGRect(x: 210, y: 0, width: 100, height:100)
        //let myScrollView = DisableVerticalScrollView(frame: frame)
        let myScrollView = NSScrollView(frame: frame)
        let image = NSImage(named: NSImage.Name(rawValue: "screen.png"))
        let imageViewFrame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height:  (image?.size.height)!)
        let imageView = NSImageView(frame: imageViewFrame)
        
        imageView.image = image
        
       
        myScrollView.documentView = imageView
        
       
        
        self.window.contentView?.addSubview(myScrollView)
        
        //滚动到顶部位置
        var newScrollOrigin : NSPoint
        let contentView: NSClipView = myScrollView.contentView
        
        if self.window.contentView!.isFlipped {
            newScrollOrigin = NSPoint(x: 0.0,y: 0.0);
        }
        else{
            newScrollOrigin = NSPoint(x: 0.0,y: imageView.frame.size.height-contentView.frame.size.height);
        }
        contentView.scroll(to: newScrollOrigin)
        
    }

    
    @IBAction func scrollAction(_ sender: NSButton) {
        var frame = self.scrollView.bounds
        frame.origin.x = frame.origin.x - 10
        self.scrollView.bounds = frame;
    }

    
    func updateData() {
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
        
        self.tableView.reloadData()
    }
   
}



extension AppDelegate: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
}

extension AppDelegate: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let data = self.datas[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
        //单元格数据
        let value = data[key]
        
        //根据表格列的标识,创建单元视图
        let view = tableView.makeView(withIdentifier: key, owner: self)
        let subviews = view?.subviews
        if (subviews?.count)!<=0 {
            return nil
        }
        
        if key.rawValue == "name" || key.rawValue == "address" {
            let textField = subviews?[0] as! NSTextField
            if value != nil {
                textField.stringValue = value as! String
            }
        }
        
        return view
    }
    
    func tableViewSelectionDidChange(_ notification: Notification){
        let tableView = notification.object as! NSTableView
        let row = tableView.selectedRow
        print("selection row \(row)")
    }
    
    
    
    
    
}




