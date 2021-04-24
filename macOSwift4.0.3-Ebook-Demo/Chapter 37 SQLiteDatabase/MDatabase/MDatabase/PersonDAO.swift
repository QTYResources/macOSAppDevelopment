//
//  PersonDAO.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class PersonDAO: MDAO {
    required init() {
        super.init()
      
        self.tableName = "Person"
        self.fldList = ["id", "name", "address", "age"]
        self.keyList = ["id"]
        let allFieldSet = NSMutableSet(array: self.fldList)
        let keyFieldSet = NSSet(array: self.keyList)
        allFieldSet.minus(keyFieldSet as Set<NSObject>)
        self.fldExcludeKeyList = allFieldSet.allObjects as! [String]
        print ("fldExcludeKeyList = \(self.fldExcludeKeyList)")
    }
}
