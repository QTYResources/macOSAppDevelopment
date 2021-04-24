//
//  MyView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


//NSAffineTransform* xform = [NSAffineTransform transform];
//[xform translateXBy:20.0 yBy:20.0];
//[xform concat];


class AffineTransView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    
        let xform = NSAffineTransform()
        xform.scaleX(by: 2, yBy: 2)
        xform.concat()
        
        
        self.wantsLayer = true
        self.layer?.borderWidth = 1
        
        let path = NSBezierPath()
        let rect = NSRect(x: 0, y: 0, width: 40, height: 40)
        path.appendRoundedRect(rect, xRadius: 10, yRadius: 10)
        path.stroke()
    
        
    }
    
    
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        
//        //保持绘图状态
//        NSGraphicsContext.saveGraphicsState()
//        
//        //设置新绘图属性
//        
//        //绘图操作
//        
//        //恢复绘制状态
//        NSGraphicsContext.restoreGraphicsState()
//        
//    }
    
}




