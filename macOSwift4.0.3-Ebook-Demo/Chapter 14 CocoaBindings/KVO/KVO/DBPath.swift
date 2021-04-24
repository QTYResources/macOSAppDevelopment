//
//  DBPath.swift
//  KVO
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class DBPath: NSObject {
    var path:String?
    var fileName:String?
    
    
    var dbPath:String {
        get {
            return path! + "" + fileName!
        }
    }
    

    
    
    override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        var keySets = super.keyPathsForValuesAffectingValue(forKey: key)
        if key == "dbPath" {
            let affectingKeys = ["path","fileName"];
            keySets.formUnion(affectingKeys)
        }
        return keySets
    }
    
    class func keyPathsForValuesAffectingDbPath() -> Set<String> {
        let affectingKeys:Set<String> = ["path","fileName"];
        return affectingKeys
    }

}
