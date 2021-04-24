//
//  BlueLayer.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/11.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class BlueLayer: CALayer {
    
    override func display() {
        let image = NSImage(named: NSImage.Name(rawValue: "gradintCell"))!
        self.contents = image
    }
    
    
    override func draw(in ctx: CGContext) {
        ctx.setLineWidth(4.0)
        ctx.setStrokeColor(NSColor.green.cgColor)
        ctx.setFillColor(NSColor.blue.cgColor)
        ctx.fill(self.bounds)
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "bounds" {
             return nil
        }
        return super.action(forKey: event)
    }
    
    
}

