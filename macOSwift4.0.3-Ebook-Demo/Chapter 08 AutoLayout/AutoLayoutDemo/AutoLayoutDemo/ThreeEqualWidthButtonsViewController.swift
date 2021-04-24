//
//  ThreeEqualWidthButtonsViewController.swift
//  AutoLayoutDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ThreeEqualWidthButtonsViewController: NSViewController {

    @IBOutlet weak var button1: NSButton!
    @IBOutlet weak var button2: NSButton!
    @IBOutlet weak var button3: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        self.configConstraints()
    }
    
    func configConstraints() {
        
        button1.leading = view.leading + 20
        button1.top = view.top + 20
        
        
    }

    
}
