//
//  AppDelegate.swift
//  Radio
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        
    }
    
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @IBAction func genderRadioAction(_ sender:NSButton){
        let tag = sender.tag
        print("tag = \(tag)")
        if tag==0 {
            
        }
        if(tag==1){
            
        }
    }
}



