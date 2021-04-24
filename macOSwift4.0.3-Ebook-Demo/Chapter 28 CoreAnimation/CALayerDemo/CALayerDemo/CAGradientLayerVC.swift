//
//  CAGradientLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CAGradientLayerVC: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.wantsLayer = true
        self.addLayer()
    }
    
    func addLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        gradientLayer.colors = [NSColor.green.cgColor,NSColor.red.cgColor,NSColor.cyan.cgColor,NSColor.purple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer?.addSublayer(gradientLayer)
    }
    
}
