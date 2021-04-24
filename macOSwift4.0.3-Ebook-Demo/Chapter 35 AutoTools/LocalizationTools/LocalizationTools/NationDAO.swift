//
//  NationDAO.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NationDAO: MDAO {

    required init() {
        super.init()
        self.tableName = "Nation"
        self.fldList = ["ID", "code", "name", "alias", "chinaName"]
        self.keyList = ["ID"]
        let allFieldSet = NSMutableSet(array: self.fldList)
        let keyFieldSet = NSSet(array: self.keyList)
        allFieldSet.minus(keyFieldSet as Set<NSObject>)
        self.fldExcludeKeyList = allFieldSet.allObjects as! [String]
        print ("fldExcludeKeyList = \(self.fldExcludeKeyList)")
    }
}
