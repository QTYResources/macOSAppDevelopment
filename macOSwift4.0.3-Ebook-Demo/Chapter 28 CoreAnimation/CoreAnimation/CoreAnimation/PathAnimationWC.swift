//
//  PathAnimationWC.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class PathAnimationWC: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        self.startPathAnimation()

    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("PathAnimationWC")
    }

    
    func startPathAnimation(){
        
        let view = self.window!.contentView
        let rootLayer = view?.layer
        
        //做为mask的Shape Layer
        let circleShapeLayer = CAShapeLayer()
        let shapePath = CGMutablePath()
        shapePath.addEllipse(in: CGRect(x: 0, y: 0, width: 160, height: 160))
        circleShapeLayer.path = shapePath
        
        //圆形图层
        let circleLayer = CALayer()
        circleLayer.frame = CGRect(x: 60, y: 60, width: 160, height: 160)
        circleLayer.backgroundColor = NSColor.purple.cgColor
        circleLayer.mask = circleShapeLayer
        circleLayer.masksToBounds = true
        rootLayer?.addSublayer(circleLayer)
        
        //旋转的图层
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: -10, y: -10, width: 20, height: 20)
        colorLayer.backgroundColor = NSColor.green.cgColor
        rootLayer?.addSublayer(colorLayer)
        
        //沿着圆形轨迹运行的关键帧动画
        let animation1 = CAKeyframeAnimation()
        animation1.keyPath = "position"
        
        let ellipsePath = CGMutablePath()
        ellipsePath.addEllipse(in: CGRect(x: 40, y: 40, width: 200, height: 200))
        animation1.path = ellipsePath
        animation1.rotationMode = kCAAnimationRotateAuto
        animation1.repeatCount = 100000
        animation1.isAdditive = true
        animation1.duration = 2.0
        animation1.calculationMode = kCAAnimationPaced
        colorLayer.add(animation1, forKey: nil)
    }
    
    
   
}

