//
//  ViewController.swift
//  NSMenu
//
//  Created by iDevFans on 16/7/9.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa
class ViewController: NSViewController {

    @IBOutlet var myMenu: NSMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popButtonClicked(_ sender: NSButton) {
      var point = sender.frame.origin
      point.x = point.x + sender.frame.size.width
      self.myMenu.popUp(positioning: nil, at: point, in: self.view)
    }
    
    
    @IBAction func menuItemClicked(_ sender: AnyObject) {
        let menuItem  = sender as! NSMenuItem
        print("\(menuItem.tag)")
    }

}



