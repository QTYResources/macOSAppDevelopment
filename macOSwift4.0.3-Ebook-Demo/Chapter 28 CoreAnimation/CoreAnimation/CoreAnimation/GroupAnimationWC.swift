//
//  GroupAnimationWC.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class GroupAnimationWC: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        self.groupAnimation()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("GroupAnimationWC")
    }
    
    
    func groupAnimation(){
        
        let view = self.window!.contentView
        let rootLayer = view?.layer
        
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        rootLayer?.addSublayer(layer)
        let animation1 = CABasicAnimation()
        animation1.keyPath = "borderWidth"
        animation1.toValue = (10)
        animation1.duration = 4.0
        
        let animation2 = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.toValue = NSColor.red.cgColor
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 4.0
        //动画保持
        groupAnimation.isRemovedOnCompletion = false
        //保持动画完成后的帧状态
        groupAnimation.fillMode = kCAFillModeForwards
        layer.add(animation1, forKey: nil)
    }
}
