//
//  DragView.swift
//  NSEvent
//
//  Created by iDevFans on 16/7/23.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class DragView: NSView {

    var dragged: Bool = false
    var centerBox: NSRect?
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        centerBox = self.bounds.insetBy(dx: 10,dy: 10);
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if(dragged){
            NSColor.blue.setFill()
        }
        else {
            NSColor.green.setFill()
        }
        dirtyRect.fill()
    }
    
    override func mouseDown(with event: NSEvent) {
        
        //获取鼠标点击位置坐标
        let eventLocation = event.locationInWindow
        //转化成视图的本地坐标
        let pointInView    = self.convert(eventLocation, from: nil)
        //判断当前鼠标位置是否在中心点附近范围内
        if NSPointInRect(pointInView, centerBox!) {
            dragged = true
        }
    }
    
    
    override func mouseDragged(with event: NSEvent) {
    
        if dragged {
            let eventLocation = event.locationInWindow
            let positionBox = NSRect(x: eventLocation.x, y: eventLocation.y, width: self.frame.size.width, height: self.frame.size.height)
            //更新视图位置
            self.frame = positionBox
            //重绘界面
            self.needsDisplay = true
        }
    }
    
    
    override func mouseUp(with event: NSEvent) {
        dragged = false
        self.needsDisplay = true
    }
    
    override func cursorUpdate(with event: NSEvent) {
        
        NSCursor.crosshair.set()
    }
}










