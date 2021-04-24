//
//  CustomView1.swift
//  NSViewController
//
//  Created by iDevFans on 16/7/15.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CustomView1: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        Swift.print("CustomView1 draw")
        //Drawing code here.
    }
    
    
    override func updateConstraints(){
       
        Swift.print("CustomView1 updateConstraints")
         super.updateConstraints()
    }
    
    override func layout() {
        
        Swift.print("CustomView1 layout")
        super.layout()
        // Do any additional setup after loading the view.
    }
    
}
