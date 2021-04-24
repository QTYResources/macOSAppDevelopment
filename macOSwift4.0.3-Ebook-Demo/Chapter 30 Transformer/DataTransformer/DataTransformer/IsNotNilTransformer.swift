//
//  IsNotNilTransformer.swift
//  DataTransformer
//
//  Created by iDevFans on 16/8/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class IsNotNilTransformer: ValueTransformer {
    //是否允许反向转换
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    //正向转化器的类名
    override class func transformedValueClass() -> Swift.AnyClass {
        return NSNumber.self
    }
    
    //正向的转化接口
    override func transformedValue(_ value: Any?) -> Any? {
        
        if value != nil {
            return NSNumber(value:true)
        }
        return NSNumber(value:false)
    }
}
