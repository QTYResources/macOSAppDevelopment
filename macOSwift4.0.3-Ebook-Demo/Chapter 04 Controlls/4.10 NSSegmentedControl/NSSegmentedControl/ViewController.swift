//
//  ViewController.swift
//  NSSegmentedControl
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: Action
    
    @IBAction func segmentedAction(_ sender: NSSegmentedControl) {
        
        let tag = sender.selectedSegment
        print("selection index = \(tag)")
        
    }
    


}



