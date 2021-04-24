//
//  TreeController.swift
//  NSTreeController
//
//  Created by iDevFans on 16/7/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class TreeController: NSTreeController {

   override func newObject() -> Any {
        
        let node = NSMutableDictionary()
        node["name"] = "Group"
        let children = NSMutableArray()
        node["children"] =  children
        let m1 = NSMutableDictionary()
        m1["name"] =  "m1"
        children.add(m1)
        
        let m2 = NSMutableDictionary()
        m2["name"] =  "m2"
        children.add(m2)
        
        return node
    }
}
