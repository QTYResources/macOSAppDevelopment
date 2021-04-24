//
//  ViewController.swift
//  NSImageView
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 chianums. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func setImageViewRoundAction(_ sender: NSButton){
        
        self.imageView.wantsLayer = true
        self.imageView.layer?.masksToBounds = true
        self.imageView.layer?.cornerRadius = 30
        self.imageView.layer?.borderWidth = 1
        self.imageView.layer?.borderColor = NSColor.green.cgColor
    }


}

