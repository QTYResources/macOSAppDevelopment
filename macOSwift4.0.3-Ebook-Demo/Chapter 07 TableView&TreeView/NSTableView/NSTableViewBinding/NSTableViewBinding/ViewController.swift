//
//  ViewController.swift
//  NSTableViewBinding
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    dynamic var datas = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        // Do any additional setup after loading the view.
    }

    func updateData() {
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
    }
}

