//
//  ViewController.swift
//  NSSlider
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
    
    @IBAction func sliderAction(_ sender :NSSlider){
        
        let intValue = sender.intValue
        print("intValue :\(intValue)")
    }

}





