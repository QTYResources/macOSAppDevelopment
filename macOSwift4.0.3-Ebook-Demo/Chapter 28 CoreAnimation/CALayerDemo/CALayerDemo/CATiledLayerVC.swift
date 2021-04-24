//
//  CATiledLayerVC.swift
//  CALayerDemo
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CATiledLayerVC: NSViewController {
    @IBOutlet weak var scrollView: NSScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layerView = TileView(frame: CGRect(x: 0, y: 0, width: 360, height: 360))
        self.scrollView.autohidesScrollers = true
        self.scrollView.documentView = layerView
    }
}
