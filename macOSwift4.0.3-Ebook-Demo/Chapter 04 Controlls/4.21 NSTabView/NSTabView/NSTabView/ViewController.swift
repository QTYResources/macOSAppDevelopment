//
//  ViewController.swift
//  NSTabView
//
//  Created by iDevFans on 16/7/6.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tabView: NSTabView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addTabBtnClicked(_ sender: NSButton) {
    
        let tabViewItem = NSTabViewItem(identifier: "Untitled")
        tabViewItem.label = "Untitled"
        let view = NSView(frame: NSZeroRect)
        tabViewItem.view = view
        self.tabView.addTabViewItem(tabViewItem)
    }
}


extension ViewController: NSTabViewDelegate {
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        print("tabView title: \(tabViewItem?.label)  identifier: \(tabViewItem?.identifier)")
    }
}



