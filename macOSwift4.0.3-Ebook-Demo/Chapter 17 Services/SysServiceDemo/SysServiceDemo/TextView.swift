//
//  TextView.swift
//  SysServiceDemo
//
//  Created by iDevFans on 16/7/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


class TextView: NSTextView {
    var registered: Bool
    override init(frame frameRect: NSRect) {
        self.registered = true
        NSApp.registerServicesMenuSendTypes([NSPasteboard.PasteboardType.string], returnTypes: [NSPasteboard.PasteboardType.string])
        super.init(frame: frameRect)
    }
    
    required init?(coder: NSCoder) {
        self.registered = true
        NSApp.registerServicesMenuSendTypes([NSPasteboard.PasteboardType.string], returnTypes: [NSPasteboard.PasteboardType.string])
        super.init(coder: coder)
    }
    
    
    override func validRequestor(forSendType sendType: NSPasteboard.PasteboardType?, returnType: NSPasteboard.PasteboardType?) -> Any? {
        
        if sendType == NSPasteboard.PasteboardType.string && returnType == NSPasteboard.PasteboardType.string {
            return self
        }
        return super.validRequestor(forSendType: sendType, returnType: returnType)
    }
    
    override func writeSelection(to pboard: NSPasteboard, types: [NSPasteboard.PasteboardType]) -> Bool {
        if (types.contains(NSPasteboard.PasteboardType.string) == false) {
            return false
        }
        
        pboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        return pboard.setString(self.string, forType: NSPasteboard.PasteboardType.string)
    }
    
    override func readSelection(from pboard: NSPasteboard) -> Bool {
        let types = pboard.types
        if (types?.contains(NSPasteboard.PasteboardType.string) == false) {
            return false
        }
        let theText = pboard.string(forType: NSPasteboard.PasteboardType.string)
        self.string = theText!
        return true
    }
}

