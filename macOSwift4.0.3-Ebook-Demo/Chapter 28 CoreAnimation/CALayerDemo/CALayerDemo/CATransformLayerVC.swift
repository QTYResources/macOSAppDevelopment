//
//  CATransformLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CATransformLayerVC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.wantsLayer = true
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        self.transformLayerSetup()
    }
    
    
    func transformLayerSetup() {
        
        let rect = NSInsetRect(self.view.frame, 10, 10)

        let myView =  NSView(frame: rect)
        myView.wantsLayer = true
        self.view.addSubview(myView)
        
        let cube = CATransformLayer()
       
        //Z轴正对自己的前后2个面
        var ct = CATransform3DMakeTranslation(0, 0, 50)
        let face1 = self.layerApplyTransform(ct)
        cube.addSublayer(face1)
        ct = CATransform3DMakeTranslation(0, 0, -50)
        let face2 = self.layerApplyTransform(ct)
        cube.addSublayer(face2)
      
        //X轴左右2个面
        ct = CATransform3DMakeTranslation(-50, 0, 0)
        ct = CATransform3DRotate(ct, -(CGFloat)(M_PI_2), 0, 1, 0)
        let face3 = self.layerApplyTransform(ct)
        cube.addSublayer(face3)
        ct = CATransform3DMakeTranslation(50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 0, 1, 0)
        let face4 = self.layerApplyTransform(ct)
        cube.addSublayer(face4)
       
        //Y轴上下2个面
        ct = CATransform3DMakeTranslation(0, 50, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 1, 0, 0)
        let face5 = self.layerApplyTransform(ct)
        cube.addSublayer(face5)
        ct = CATransform3DMakeTranslation(0, -50, 0)
        ct = CATransform3DRotate(ct, -(CGFloat)(M_PI_2), 1, 0, 0)
        let face6 = self.layerApplyTransform(ct)
        cube.addSublayer(face6)
        
        //立方体的位置
        cube.position = CGPoint(x: 240, y: 240)
        
        //m34,透视变换系数
        var pt = CATransform3DIdentity
        pt.m34 = -1 / 500.0
        myView.layer?.sublayerTransform = pt
        myView.layer?.addSublayer(cube)
    }
    
    func layerApplyTransform(_ transform: CATransform3D) -> CALayer {
        //create cube  layer
        let face = CALayer()
        face.frame = CGRect(x: -50, y: -50, width: 100, height: 100)
        
        //apply a random color
        let red = CGFloat(arc4random() % 255) / 255.0
        let green = CGFloat(arc4random() % 255) / 255.0
        let blue = CGFloat(arc4random() % 255) / 255.0
        face.backgroundColor = NSColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        face.transform = transform
        return face
    }
}
