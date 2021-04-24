//
//  TwoEqualWidthButtonsViewController.swift
//  AutoLayoutDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class TwoEqualWidthButtonsViewController: NSViewController {

    @IBOutlet weak var button: NSButton!
    @IBOutlet weak var dynamicButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.translatesAutoresizingMaskIntoConstraints = false
        dynamicButton.translatesAutoresizingMaskIntoConstraints = false
        self.configConstraints()
    }
    
    func configConstraints() {
        
       button.leading = view.leading + 20
       button.top = view.top + 20
        
       dynamicButton.leading = button.trailing + 10
       dynamicButton.top = view.top + 20
        
       dynamicButton.width = button.width
       view.trailing = dynamicButton.trailing + 20
        
    }
}
