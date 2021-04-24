//
//  TrackView.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class TrackView: NSView {

    var tracking: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let eyeBox = CGRect(x: 0, y: 0, width: 80, height: 80)
        let trackingArea = NSTrackingArea(rect: eyeBox, options: [NSTrackingArea.Options.mouseMoved,NSTrackingArea.Options.mouseEnteredAndExited,NSTrackingArea.Options.activeInKeyWindow,NSTrackingArea.Options.cursorUpdate ], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if(tracking){
            self.wantsLayer = true
            self.layer?.borderWidth = 10
            self.layer?.borderColor = NSColor.red.cgColor
        }
        else {
            self.wantsLayer = true
            self.layer?.borderWidth = 1
            self.layer?.borderColor = NSColor.gray.cgColor
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        tracking = true
        self.needsDisplay = true
    }
    
    override func mouseMoved(with event: NSEvent) {
        
        
    }
    
    override func mouseExited(with event: NSEvent) {
        tracking = false
        self.needsDisplay = true
    }
    
    //鼠标光标更新为十字架形状
    override func cursorUpdate(with event: NSEvent) {
       NSCursor.crosshair.set()
    }
    
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        
        let characters = event.characters
        
        if characters == "i" {
            
            NSApp.terminate(self)
            
            return true
        }
        
        return false
    }
    
}






