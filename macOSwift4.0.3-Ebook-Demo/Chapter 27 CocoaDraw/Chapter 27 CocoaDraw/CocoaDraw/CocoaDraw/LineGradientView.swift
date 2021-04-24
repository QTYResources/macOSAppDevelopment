//
//  LineGradientView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class LineGradientView: NSView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
       // self.drawLinerGradient()
        
        //self.drawPointGradient()
        
        self.drawRectGradient()
    }
    
    func drawLinerGradient(){
        let bounds = self.bounds
        let clipShape = NSBezierPath()
        clipShape.appendRect(bounds)
        let aGradient = NSGradient(colorsAndLocations: (NSColor.red, 0.0),(NSColor.green,0.5),(NSColor.blue,1.0))
        aGradient?.draw(in: clipShape, angle: 90)
    }
    
    func drawPointGradient(){

        let aGradient = NSGradient(colorsAndLocations: (NSColor.red, 0.0),(NSColor.green,0.5),(NSColor.blue,1.0))
        
        let centerPoint = NSPoint(x: 0, y: 0)
        let otherPoint =  NSPoint(x: 0, y: 60)
        
        //aGradient?.draw(from: centerPoint, to: otherPoint, options: .drawsBeforeStartingLocation)
        
        aGradient?.draw(from: centerPoint, to: otherPoint, options: .drawsAfterEndingLocation)
    }
    
    
    func drawRectGradient(){
        
        let aGradient = NSGradient(colorsAndLocations: (NSColor.red, 0.0),(NSColor.green,0.5),(NSColor.blue,1.0))
        
        let rect =  NSRect(x: 10, y: 10, width: 40, height: 40)
        
        aGradient?.draw(in: rect, angle: 90)
    }
    
}




