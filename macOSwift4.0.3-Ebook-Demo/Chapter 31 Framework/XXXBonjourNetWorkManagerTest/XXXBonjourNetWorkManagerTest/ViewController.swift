//
//  ViewController.swift
//  XXXBonjourNetWorkManagerTest
//
//  Created by iDevFans on 16/10/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import XXXBonjourNetWork

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        XXXBonjourNetWorkManager.shared.start()
        Helper.show()
    }
}

