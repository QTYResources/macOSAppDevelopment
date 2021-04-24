//
//  WindowController.swift
//  TableViewControllerDemo
//
//  Created by iDevFans on 16/8/21.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    lazy var viewController: ViewController = {
        let vc = ViewController(nibName: NSNib.Name(rawValue: "ViewController"), bundle: nil)
        return vc
    }()
    
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("WindowController")
    }
    
   
    
    override func windowDidLoad() {
        
        super.windowDidLoad()
        
        self.contentViewController = self.viewController
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
