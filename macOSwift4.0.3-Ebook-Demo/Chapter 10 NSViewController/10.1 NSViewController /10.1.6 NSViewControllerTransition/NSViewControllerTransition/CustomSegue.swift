//
//  CustomSegue.swift
//  NSViewControllerTransition
//
//  Created by iDevFans on 16/7/17.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class CustomSegue: NSStoryboardSegue {

    override func perform(){
        
        let sourceViewController      = self.sourceController as! NSViewController;
        let destinationViewController = self.destinationController as! NSViewController
        
        let animator = PresentCustomAnimator()
        
        sourceViewController.presentViewController(destinationViewController , animator: animator)
        
    }
}
