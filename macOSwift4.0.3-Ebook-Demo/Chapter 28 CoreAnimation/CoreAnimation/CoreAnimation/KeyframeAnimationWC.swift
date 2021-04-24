//
//  KeyframeAnimationWC.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class KeyframeAnimationWC: NSWindowController {

    @IBOutlet weak var userNameTextField: NSTextField!
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("KeyframeAnimationWC")
    }
    
    @IBAction func okAction(_ sender: AnyObject) {
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.isAdditive = true
        animation.values = [(-15), (15), (-10), (10), (-8), (8), (-6), (6), (-4), (4)]
        animation.duration = 1
        self.userNameTextField.layer?.add(animation, forKey: nil)
    }
    
}
