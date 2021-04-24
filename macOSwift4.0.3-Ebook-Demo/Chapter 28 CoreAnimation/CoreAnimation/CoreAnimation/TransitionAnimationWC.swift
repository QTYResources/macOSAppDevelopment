//
//  TransitionAnimationWC.swift
//  CoreAnimation
//
//  Created by iDevFans on 16/10/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class TransitionAnimationWC: NSWindowController {
    @IBOutlet weak var imageView: NSImageView!

    override func windowDidLoad() {
        super.windowDidLoad()

    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("TransitionAnimationWC")
    }
    
   
    
    func transitionAnimation() {
        let transition = CATransition()
        transition.startProgress = 0.5
        transition.endProgress = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        transition.duration = 1.0
        self.imageView!.layer?.add(transition, forKey: "transition")
    }
    
    @IBAction func transitionAction(_ sender: AnyObject) {
        self.transitionAnimation()
        self.imageView!.isHidden = !self.imageView!.isHidden
    }
}


