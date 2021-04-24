//
//  AppDelegate.swift
//  NSTabLessView
//
//  Created by zhaojw on 2017/10/22.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var tabView: NSTabView!
    
    @IBAction func segmentAction(_ sender: NSSegmentedControl) {
        let index = sender.selectedSegment
        tabView.selectTabViewItem(at: index)
    }
    
    var controllers:[NSViewController] {
        let vc1 = NSViewController()
        let vc2 = NSViewController()
        return [vc1,vc2]
    }
    
    func addViewController() {
        let tabCount = tabView.tabViewItems.count
        for (index,vc) in controllers.enumerated() {
            if index <= tabCount - 1 {
                let tabItem = tabView.tabViewItems[index]
                if let tabItemView = tabItem.view {
                    tabItemView.addSubview(vc.view)
                    vc.view.frame = tabItemView.bounds
                }
            }
        }
    }

}



