//
//  BuddyListDAO.swift
//  BuddyMultiDelegateDemo
//
//  Created by iDevFans on 16/9/26.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class BuddyListDAO: MDAO {
    required init() {
        super.init()
        
        self.tableName = "BuddyList"
        self.fldList = ["ID","nickName","status"]
        self.keyList = ["ID"]
        let allFieldSet = NSMutableSet(array: self.fldList)
        let keyFieldSet = NSSet(array: self.keyList)
        allFieldSet.minus(keyFieldSet as Set<NSObject>)
        self.fldExcludeKeyList = allFieldSet.allObjects as! [String]
        print ("fldExcludeKeyList = \(self.fldExcludeKeyList)")
    }
}
