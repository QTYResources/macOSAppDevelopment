//
//  CATextLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CATextLayerVC: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.addLayer()
    }
    
    func addLayer(){
        let textLayer = CATextLayer()
        textLayer.fontSize = 14.0
        //分辨率适配
        textLayer.contentsScale = (NSScreen.main?.backingScaleFactor)!
        textLayer.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
        textLayer.string = "text string"
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.backgroundColor = NSColor.clear.cgColor
        textLayer.foregroundColor = NSColor.black.cgColor
        self.view.layer?.addSublayer(textLayer)
        
        CAValueFunction
    }
}
