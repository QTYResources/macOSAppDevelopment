//
//  NSButtonX.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class NSButtonX: NSButton {

    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        
        let characters = event.characters
        
        if characters == "j" {
            
            NSApp.terminate(self)
            
            return true
        }
        
        return false
    }
}
