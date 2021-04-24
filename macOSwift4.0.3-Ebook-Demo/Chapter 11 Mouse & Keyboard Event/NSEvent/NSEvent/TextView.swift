//
//  TextView.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class TextView: NSTextView {

//    override func doCommand(by selector: Selector) {
//        
//        if selector == #selector(NSResponder.insertNewline(_:)) {
//            NSLog("insertNewline")
//        }
//    }
    
    
    override var acceptsFirstResponder: Bool {
        return true
    }
}
