//
//  PresentCustomAnimator.swift
//  NSViewControllerTransition
//
//  Created by iDevFans on 16/7/16.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class PresentCustomAnimator: NSObject,NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        let bottomVC = fromViewController
        let topVC = viewController
        topVC.view.wantsLayer = true
        topVC.view.alphaValue = 0
        
        bottomVC.view.addSubview(topVC.view)
        
        topVC.view.layer?.backgroundColor = NSColor.gray.cgColor
        
        NSAnimationContext.runAnimationGroup( {context in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 1
            
            }, completionHandler:nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        
        let topVC = viewController
        
        NSAnimationContext.runAnimationGroup( {context in
            context.duration = 0.5
            topVC.view.animator().alphaValue = 0
            
            }, completionHandler: { topVC.view.removeFromSuperview() } )
    }
}
