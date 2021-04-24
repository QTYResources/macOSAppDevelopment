//
//  AppDelegate.swift
//  NSTextView
//
//  Created by iDevFans on 16/6/28.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa





@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate,NSTextDelegate, NSTextStorageDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet var textView: NSTextView!

    @IBOutlet var attibuteTextView: NSTextView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let attributedString = NSMutableAttributedString(string:"attributedString" as String)
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: NSColor.blue as Any ], range:  NSMakeRange(0, 10))
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: NSColor.green as Any ], range:  NSMakeRange(10, 6))
        
        textView.textStorage?.setAttributedString(attributedString)
        
        textView.textStorage?.delegate = self
        //textView.textColor = NSColor.black
        
       // attibuteTextView.textStorage = attributedString
        
    }
    
    
    override func textStorageDidProcessEditing(_ notification: Notification) {
        self.perform(#selector(self.setHeightToMatchContents), with: nil, afterDelay: 0.0)
    }
    
    @objc func setHeightToMatchContents() {
        let naturalSize: NSSize = self.naturalSize()
        if let scrollView = self.textView.enclosingScrollView {
            let frame = scrollView.frame
            scrollView.frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, naturalSize.height + 4)
        }
    }
    
    func naturalSize() -> NSSize {
        let bounds: NSRect = self.textView.bounds
        let layoutManager: NSLayoutManager = textView.textStorage!.layoutManagers[0]
        let textContainer: NSTextContainer = layoutManager.textContainers[0]
        textContainer.containerSize = NSMakeSize(bounds.size.width, 1.0e7)
        layoutManager.glyphRange(for: textContainer)
        let naturalSize: NSSize? = layoutManager.usedRect(for: textContainer).size
        return naturalSize!
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func textDidBeginEditing(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            let text = textView.string
            print("textDidBeginEditing text \(text)")
            
        }
    }
    
    func textDidEndEditing(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
            let text = textView.string
            print("textDidEndEditing text \(text)")
        }
    }

    func textDidChange(_ notification: Notification) {
        if let textView = notification.object as? NSTextView {
             let text = textView.string 
             print("textDidChange text \(text)")
            
        }
    }

}



