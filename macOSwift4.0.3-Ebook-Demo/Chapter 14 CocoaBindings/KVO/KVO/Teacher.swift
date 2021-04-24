//
//  Teacher.swift
//  KVO
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class Teacher: NSObject {
    var school: String?
    var address: String?
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print("keyPath:\(keyPath)")
        
        print("object:\(object)")
        
        print("change:\(change)")
    }
    

    
}
