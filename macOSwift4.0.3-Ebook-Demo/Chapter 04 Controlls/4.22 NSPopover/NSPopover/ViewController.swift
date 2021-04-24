//
//  ViewController.swift
//  NSPopover
//
//  Created by iDevFans on 16/7/6.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    lazy var sharePopover:NSPopover = {
        let popover = NSPopover()
        let controller = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "Share")) as! NSViewController
        popover.contentViewController = controller
        popover.behavior = .transient
        return popover
    }()
    
    
    lazy var feedbackPopover:NSPopover = {
        let popover = NSPopover()
        let controller = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "Feedback")) as! NSViewController
        popover.contentViewController = controller
        popover.behavior = .transient
        return popover
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: Action
    
    @IBAction func sharePopover(_ sender:NSButton) {
        
        sharePopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
        
    }
    
    @IBAction func feedbackPopover(_ sender:NSButton) {
        
        feedbackPopover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .minY)
        
    }
    
    

}






