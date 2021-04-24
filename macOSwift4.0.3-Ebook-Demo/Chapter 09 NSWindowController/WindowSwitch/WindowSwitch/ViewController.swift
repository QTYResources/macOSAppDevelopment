//
//  ViewController.swift
//  WindowSwitch
//
//  Created by iDevFans on 16/8/22.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var mainAppWVC: NSWindowController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func loginOk(_ sender: NSButton) {
       
        let sb = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        
        self.view.window?.close()
        
        mainAppWVC = sb.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "MainAppWVC")) as? NSWindowController
        
        mainAppWVC?.showWindow(self)
        
    }


}

