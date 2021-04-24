//
//  ViewController.swift
//  KVC
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person()
        person.name = "john"
        person.age = 20
        
        let phone = Phone()
        phone.family = "010-67854545"
        phone.office = "010-65213456"
        person.phone = phone
        
        
        let dd = person.value(forKey: "age")
        

        
        //使用KVC方法获取属性
        let name = person.value(forKey: "name")
        print("name \(name)")
        //使用KVC修改属性
        person.setValue("Habo", forKey: "name")
        
        
        person.setValue(20, forKey: "age")
        
        
        //使用path获取属性
        let officePhone = person.value(forKeyPath: "phone.office")
        print("officePhone \(officePhone)")
        //修改属性
        person.setValue("010-678545466", forKeyPath: "phone.office")
        
    }
    
    override func setNilValueForKey(_ key: String) {
        if key == "hidden" {
            self.setValue(true, forKey: key)
        }
        else{
            super.setNilValueForKey(key)
        }
    }
}




