//
//  ViewController.swift
//  WindowCenter
//
//  Created by iDevFans on 16/10/15.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var myView: NSView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.isRestorable = false
        self.view.window?.center()
//        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
//
//        self.view.window?.setFrame(rect, display: true)
    }

    @IBAction func showViewWindow(_ sender: AnyObject) {
        
        let w = self.myView.window
        
        print("ViewController w =\(w)")
        print("ViewController vc  =\(self.view)")
    }
}

