//
//  ViewController.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/24.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bkColor = NSColor(hex:0x2c3135)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bkColor.cgColor
        
    }
    
}


