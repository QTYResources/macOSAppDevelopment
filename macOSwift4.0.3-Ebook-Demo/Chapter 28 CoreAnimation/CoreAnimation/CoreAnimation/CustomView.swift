//
//  CustomView.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/10.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CustomView: NSView {
    

    override var wantsUpdateLayer: Bool {
        return true
    }
    
    override func updateLayer(){
        self.layer?.backgroundColor = NSColor.white.cgColor;
        self.layer?.borderColor = NSColor.red.cgColor;
    }
    
    
    var lineColor:NSColor = NSColor.black
        {
        didSet
        {
            self.needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //self.layer?.backgroundColor = NSColor.red.cgColor
        lineColor.set()
        self.bounds.frame(withWidth: 2)
    }
    
    func animationSetup2() {
        let animation1 = CABasicAnimation()
        animation1.keyPath = "borderWidth"
        animation1.toValue = (10)
        animation1.delegate = self
        self.layer?.add(animation1, forKey: nil)
    }
    
    func animation2(){
        CATransaction.begin()
        let animation1 = CABasicAnimation()
        animation1.keyPath = "borderWidth"
        animation1.toValue = (10)
        animation1.delegate = self
        self.layer?.add(animation1, forKey: nil)
        CATransaction.commit()
        CATransaction.setCompletionBlock({ ()-> Void in
            self.layer?.borderWidth = 10
        })
    }
    
    
    func pause(_ layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    
    func resumeLayer(_ layer: CALayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    
    override func animation(forKey key: NSAnimatablePropertyKey) -> Any? {
        if (key.rawValue == "lineColor") {
            return CABasicAnimation()
        }
        return super.animation(forKey: key)
    }
    

    override class func defaultAnimation(forKey key: NSAnimatablePropertyKey) -> Any? {
        if (key.rawValue == "lineColor") {
            return CABasicAnimation()
        }
        return super.defaultAnimation(forKey:key)
    }
}


extension CustomView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.layer?.borderWidth = 10
    }
}

//extension CustomView: CALayerDelegate {
//    
//    func display(_ layer: CALayer){
//        let image = NSImage(named: "gradintCell")!
//        layer.contents = image.cgImage
//    }
//
//    
//    func draw(_ layer: CALayer, in ctx: CGContext) {
//        ctx.setLineWidth(4.0)
//        ctx.setStrokeColor(NSColor.green.cgColor)
//        ctx.setFillColor(NSColor.blue.cgColor)
//        ctx.fill(layer.bounds)
//    }
//    
//    func action(for layer: CALayer, forKey event: String) -> CAAction? {
//        
//        if event == "contents"  {
//            let theAnimation = CATransition()
//            theAnimation.duration = 1.0
//            theAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//            theAnimation.type = kCATransitionPush
//            theAnimation.subtype = kCATransitionFromLeft
//            return theAnimation
//        }
//        return nil
//    }
//    
//}




