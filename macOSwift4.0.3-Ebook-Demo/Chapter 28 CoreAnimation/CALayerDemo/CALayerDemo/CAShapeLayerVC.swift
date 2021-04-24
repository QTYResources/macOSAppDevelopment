//
//  CAShapeLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CAShapeLayerVC: NSViewController {
    var shapeLayer: CAShapeLayer!
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.addLayer()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.animationAction), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: .commonModes)

    }
    
    func addLayer(){
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 20))
        path.addLine(to: CGPoint(x: 200, y: 20))
        shapeLayer.path = path
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = NSColor.green.cgColor
        self.view.layer?.addSublayer(shapeLayer)
    }

    @IBAction func animationAction(_ sender: AnyObject) {
        if self.shapeLayer.strokeEnd < 1.0 {
            self.shapeLayer.strokeEnd += 0.1
        }
        else {
            self.timer.invalidate()
        }
    }
}
