//
//  CAEmitterLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CAEmitterLayerVC: NSViewController {

    @IBOutlet weak var myView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.addLayer()
    }
    
    func addLayer(){
        let rootLayer = self.view.layer
        //粒子源系统定义
        let snowEmitter = CAEmitterLayer()
        //异步绘制
        snowEmitter.drawsAsynchronously = true
        snowEmitter.name = "snowEmitter"
        snowEmitter.zPosition = 10.00
        snowEmitter.emitterPosition = CGPoint(x: 300.00, y: 300.00)
        snowEmitter.renderMode = kCAEmitterLayerBackToFront
        snowEmitter.emitterShape = kCAEmitterLayerCircle
        snowEmitter.emitterZPosition = -43.00
        snowEmitter.emitterSize = CGSize(width: 160, height: 160)
        snowEmitter.velocity = 20.57
        snowEmitter.emitterMode = kCAEmitterLayerPoints
        snowEmitter.birthRate = 10
        //第一个粒子模型定义
        let snowFlakesCell = CAEmitterCell()
        snowFlakesCell.name = "snowFlakesCell"
        //粒子内容图象,必须是CGImageRef类型
        snowFlakesCell.contents = NSImage(named: NSImage.Name(rawValue: "Ball_red.png"))?.cgImage
        
        let colorRefSnowflakescell = CGColor(red: 0.77, green: 0.65, blue: 0.55, alpha: 0.50)
        snowFlakesCell.color = colorRefSnowflakescell
        snowFlakesCell.redRange = 0.90
        snowFlakesCell.greenRange = 0.80
        snowFlakesCell.blueRange = 0.70
        snowFlakesCell.alphaRange = 0.80
        snowFlakesCell.redSpeed = 0.92
        snowFlakesCell.greenSpeed = 0.84
        snowFlakesCell.blueSpeed = 0.74
        snowFlakesCell.alphaSpeed = 0.55
        snowFlakesCell.magnificationFilter = kCAFilterTrilinear
        snowFlakesCell.scale = 0.72
        snowFlakesCell.scaleRange = 0.14
        snowFlakesCell.spin = 0.38
        snowFlakesCell.spinRange = 0
        snowFlakesCell.emissionLatitude = 1.75
        snowFlakesCell.emissionLongitude = 1.75
        snowFlakesCell.emissionRange = 3.49
        snowFlakesCell.lifetime = 9.00
        snowFlakesCell.lifetimeRange = 2.37
        snowFlakesCell.birthRate = 10.00
        snowFlakesCell.scaleSpeed = -0.25
        snowFlakesCell.velocity = 4.00
        snowFlakesCell.velocityRange = 2.00
        snowFlakesCell.xAcceleration = 1.00
        snowFlakesCell.yAcceleration = 10.00
        //第二个例子模型定义
        let snowFlakesCell2 = CAEmitterCell()
        snowFlakesCell2.emissionRange = .pi
        snowFlakesCell2.lifetime = 10.0
        snowFlakesCell2.birthRate = 4.0
        snowFlakesCell2.velocity = 2.0
        snowFlakesCell2.velocityRange = 100.0
        snowFlakesCell2.yAcceleration = 300.0
        snowFlakesCell2.contents = NSImage(named: NSImage.Name(rawValue: "Ball_green.png"))?.cgImage
        snowFlakesCell2.magnificationFilter = kCAFilterNearest
        snowFlakesCell2.scale = 0.72
        snowFlakesCell2.scaleRange = 0.14
        snowFlakesCell2.spin = 0.38
        snowFlakesCell2.spinRange = 0
        //粒子发射源配置粒子模型
        snowEmitter.emitterCells = [snowFlakesCell, snowFlakesCell2]
        rootLayer?.addSublayer(snowEmitter)
    }
}
