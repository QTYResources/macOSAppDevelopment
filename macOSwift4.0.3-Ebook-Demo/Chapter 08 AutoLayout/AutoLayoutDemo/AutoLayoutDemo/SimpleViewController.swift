//
//  SimpleViewController.swift
//  AutoLayoutDemo
//
//  Created by iDevFans on 16/9/25.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class SimpleViewController: NSViewController {
    
    lazy var customView: NSView = {
       let customView = NSView()
       customView.wantsLayer = true
       customView.layer?.backgroundColor = NSColor.red.cgColor
       customView.translatesAutoresizingMaskIntoConstraints = false
       return customView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(customView)
        self.configConstraints()
    }
    
    func configConstraints() {
        customView.leading  = view.leading + 20
        customView.trailing = view.trailing - 20
        customView.top      = view.top + 20
        customView.bottom   = view.bottom - 20
    }
    
}
