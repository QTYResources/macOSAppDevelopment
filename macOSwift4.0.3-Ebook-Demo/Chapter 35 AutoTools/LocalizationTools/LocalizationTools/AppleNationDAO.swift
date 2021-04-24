//
//  AppleNationDAO.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class AppleNationDAO: MDAO {

    required init() {
        super.init()
        self.tableName = "AppleNation"
        self.fldList = ["ID", "code", "name", "alias", "chinaName"]
        self.keyList = ["ID"]
        let allFieldSet = NSMutableSet(array: self.fldList)
        let keyFieldSet = NSSet(array: self.keyList)
        allFieldSet.minus(keyFieldSet as Set<NSObject>)
        self.fldExcludeKeyList = allFieldSet.allObjects as! [String]
        print ("fldExcludeKeyList = \(self.fldExcludeKeyList)")
    }
    
}
