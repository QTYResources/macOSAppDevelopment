//
//  CustomView.swift
//  NSViewController
//
//  Created by iDevFans on 16/7/14.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CustomView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        Swift.print("CustomView draw")
        //Drawing code here.
    }
    
    
    override func updateConstraints(){
        Swift.print("CustomView updateConstraints")
        super.updateConstraints()
        
    }
    
    
    override func display() {
        
        Swift.print("CustomView display")
        super.display()
        // Do any additional setup after loading the view.
    }
    
    override func layout() {
        
        Swift.print("CustomView layout")
        super.layout()
        // Do any additional setup after loading the view.
    }
}
