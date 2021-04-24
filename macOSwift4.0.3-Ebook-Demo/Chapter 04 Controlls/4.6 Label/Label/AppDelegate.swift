//
//  AppDelegate.swift
//  Label
//
//  Created by iDevFans on 16/6/28.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.addLabel()
        self.addRichableLabel()
    }


    func addLabel(){
        let frame = CGRect(x: 100, y: 10, width: 80, height: 24)
        let label = NSTextField(frame: frame)
        label.isEditable = false
        label.isBezeled = false
        label.drawsBackground = false
        label.stringValue = "Name Label"
        
        self.window.contentView?.addSubview(label)
    }
    
    
    func addRichableLabel(){
        
        let text = NSString(string: "please visit http://www.macdev.io/")
        let attributedString = NSMutableAttributedString(string:text as String)
        let linkURLText = "http://www.macdev.io/"
        let linkURL = NSURL(string:linkURLText)
        
        let selectedRange = text.range(of: linkURLText)
    
        attributedString.beginEditing()
        attributedString.addAttribute(NSAttributedStringKey.link, value:linkURL!, range: selectedRange)
        
        attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value:NSColor.blue, range: selectedRange)
        
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle, value:NSUnderlineStyle.styleSingle.rawValue, range: selectedRange)
        attributedString.endEditing()
        
        let frame = CGRect(x: 50, y: 50, width: 280, height: 80)
        let richTextLabel = NSTextField(frame: frame)
        richTextLabel.isEditable = false
        richTextLabel.isBezeled = false
        richTextLabel.drawsBackground = false
        richTextLabel.attributedStringValue = attributedString
        
        self.window.contentView?.addSubview(richTextLabel)
        
    }
}


