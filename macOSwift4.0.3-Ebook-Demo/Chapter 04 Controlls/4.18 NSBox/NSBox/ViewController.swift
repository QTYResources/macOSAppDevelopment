//
//  ViewController.swift
//  NSBox
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let frame = CGRect(x: 15, y: 250, width: 250, height: 1)
        let horizontalSeparator = NSBox(frame: frame)
        horizontalSeparator.boxType = .separator
        
        self.view.addSubview(horizontalSeparator)
        
        
//        
//        NSBox *box=[[NSBox alloc]
//            initWithFrame:NSMakeRect(15.0,200.0,160.0,100)];
//        [box setBoxType:NSBoxPrimary];
//        NSSize margin = NSMakeSize(20, 20);
//        box.contentViewMargins = margin;
//        
//        NSTextField *textField = [[ NSTextField alloc]
//            initWithFrame:NSMakeRect(10,10,80,20)];
//        [box.contentView addSubview:textField];
        let boxFrame = CGRect(x: 200, y: 140, width: 160, height: 100)
        let box = NSBox(frame: boxFrame)
        box.boxType = .primary
        let margin  = NSSize(width: 20, height: 20)
        box.contentViewMargins = margin
        box.title = "Box"
        
        let textFieldFrame = CGRect(x: 10, y: 10, width: 80, height: 20)
        let textField = NSTextField(frame: textFieldFrame)
        box.contentView?.addSubview(textField)
        
        self.view.addSubview(box)
        
    }


    

}





