//
//  PresentViewController.swift
//  NSViewControllerTransition
//
//  Created by iDevFans on 16/7/16.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class PresentViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction  func dismissAction(_ sender: Any?) {
        if (self.presenting != nil) {
            self.dismiss(self)
        } else {
            self.view.window?.close();
        }
    }
}
