//
//  sfsf.swift
//  ImageAassetAutomator
//
//  Created by zhaojw on 2017/10/31.
//  Copyright © 2017年 macdev. All rights reserved.
//

import Cocoa

extension NSPasteboard.PasteboardType {
    static let backwardsCompatibleFileURL: NSPasteboard.PasteboardType = {
        if #available(OSX 10.13, *) {
            return NSPasteboard.PasteboardType.fileURL
        } else {
            return NSPasteboard.PasteboardType(kUTTypeFileURL as String)
        }
        
    } ()
}
