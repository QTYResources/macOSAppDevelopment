//
//  SplitViewController.swift
//  NSSplitVCCodeCreateDemo
//
//  Created by iDevFans on 16/7/19.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class SplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item1 = NSSplitViewItem()
        item1.viewController = SubViewController()
        item1.canCollapse = true
        item1.holdingPriority = NSLayoutConstraint.Priority(rawValue: 250)
        
        let item2 = NSSplitViewItem()
        item2.viewController = SubViewController()
        item2.canCollapse = true
        item2.holdingPriority = NSLayoutConstraint.Priority(rawValue: 270)
        
        
        self.splitView.isVertical = true
        
        self.addSplitViewItem(item1)
        self.addSplitViewItem(item2)
        
        let item1WidthGreaterThanOrEqualAnchor = item1.viewController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 200);
        
        let item1WidthlessThanOrEqualAnchor = item1.viewController.view.widthAnchor.constraint(lessThanOrEqualToConstant: 300);
        
        
        let item2WidthGreaterThanOrEqualAnchor = item2.viewController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100);
        
        let item2WidthlessThanOrEqualAnchor = item2.viewController.view.widthAnchor.constraint(lessThanOrEqualToConstant: 800);
        
        
        NSLayoutConstraint.activate([item1WidthGreaterThanOrEqualAnchor, item1WidthlessThanOrEqualAnchor, item2WidthGreaterThanOrEqualAnchor, item2WidthlessThanOrEqualAnchor])
    
    }
    
  
}
