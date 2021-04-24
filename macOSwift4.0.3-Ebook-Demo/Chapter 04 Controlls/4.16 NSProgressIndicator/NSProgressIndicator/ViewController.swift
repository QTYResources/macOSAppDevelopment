//
//  ViewController.swift
//  NSProgressIndicator
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        createProgressIndicator()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startAnimationAction(_ sender: NSButton){
        self.progressIndicator.isHidden = false
        self.progressIndicator.startAnimation(self)
    }
    
    
    @IBAction func stopAnimationAction(_ sender: NSButton){
        
        self.progressIndicator.stopAnimation(self)
         self.progressIndicator.isHidden = true
    }
    
    func createProgressIndicator() {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.frame = NSRect(x: 50, y: 50, width: 40, height: 40)
        progressIndicator.style = .spinning
        self.view.addSubview(progressIndicator)
        progressIndicator.startAnimation(self)
    }
}





