//
//  CAReplicatorLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CAReplicatorLayerVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.addLayer()
    }
    
    func addLayer(){
       
        let copiedLayer = CAReplicatorLayer()
        self.view.layer?.addSublayer(copiedLayer)
        //复制的个数
        copiedLayer.instanceCount = 3
        //复制时延时间隔
        copiedLayer.instanceDelay = 0.3
        //颜色的R G B 递减
        copiedLayer.instanceRedOffset = -0.1
        copiedLayer.instanceBlueOffset = -0.1
        copiedLayer.instanceGreenOffset = -0.1
        //复制的层之间 X,Y,Z轴的变换
        copiedLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        
        //创建子层
        let layer = CALayer()
        layer.frame = CGRect(x: 10.0, y: 10.0, width: 10.0, height: 100.0)
        layer.backgroundColor = NSColor.green.cgColor
       
        //子层动画
        let animation = CABasicAnimation(keyPath: "position.y")
        //位置Y坐标随机变化
        animation.toValue = (layer.position.y - CGFloat( arc4random() % 100))
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
     
        animation.autoreverses = true
        animation.repeatCount = 100000
        layer.add(animation, forKey: nil)
        //增加子层到复制层
        copiedLayer.addSublayer(layer)

    }
    
}
