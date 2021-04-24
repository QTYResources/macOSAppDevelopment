//
//  Person.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class Person: MModel {
    var id: Int = 0
    var name: String?
    var address: String?
    var age: Int = 0
    
    convenience init(dictionary: [String : AnyObject]) {
        self.init()
        self.setValuesForKeys(dictionary)
    }
}
