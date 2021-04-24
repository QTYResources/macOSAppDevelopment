//
//  BasicXibViewController.swift
//  CreateViewController
//
//  Created by iDevFans on 16/7/15.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class BasicXibViewController: NSViewController {

    required init() {
       super.init(nibName: NSNib.Name(rawValue: "BasicXibViewController"), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
