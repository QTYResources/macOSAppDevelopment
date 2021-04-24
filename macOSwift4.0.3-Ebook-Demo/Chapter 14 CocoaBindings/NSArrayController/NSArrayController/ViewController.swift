//
//  ViewController.swift
//  NSArrayController
//
//  Created by iDevFans on 16/7/28.
//  Copyright © 2016年 http://macdev.io All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var arrayController: NSArrayController!
    
    @objc dynamic var employees:[Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //使用代码绑定
        self.arrayController.bind(NSBindingName(rawValue: "contentArray"), to: self, withKeyPath: "employees", options: [NSBindingOption.allowsEditingMultipleValuesSelection:true])
        
        self.configData()
    }

    func configData(){
        let e1 = Employee()
        e1.id = 1
        e1.name = "mark"
        e1.age = 10
        e1.address = "beijing"
        let e2 = Employee()
        e2.id = 2
        e2.name = "john"
        e2.age = 20
        e2.address = "hongkong"
        
        self.employees = [e1,e2]
    }
}

