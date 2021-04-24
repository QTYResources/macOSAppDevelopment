//
//  ShadowDrawView.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ShadowDrawView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

      
        //保存绘图状态
        NSGraphicsContext.saveGraphicsState()
        
        //定义阴影
        let theShadow = NSShadow()
        theShadow.shadowOffset = NSMakeSize(5.0, -5.0)
        theShadow.shadowBlurRadius = 2.0
        //阴影为蓝色
        theShadow.shadowColor = NSColor.blue.withAlphaComponent(0.3)
        
        //设置绘图使用阴影
        theShadow.set()
        
        // 定义绘图的矩形
        let rect = NSInsetRect(dirtyRect, 40, 40)
        
        //设置填充颜色－红色
        NSColor.red.setFill()
        
        //绘制矩形
        NSBezierPath.fill(rect)
        
        //恢复绘图状态
        NSGraphicsContext.restoreGraphicsState()
        
    }
}
