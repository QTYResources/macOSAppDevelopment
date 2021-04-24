//
//  TypeMapValueTransformer.swift
//  DataTransformer
//
//  Created by iDevFans on 16/8/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


public enum DBDataType : UInt {
    
    case boolDataType
    
    case stringDataType
    
    case intDataType
    
    case dateDataType
    
    case blobDataType
    
}

extension NSValueTransformerName {
    static var typeMapValueTransformerName: NSValueTransformerName {
        return  NSValueTransformerName("kTypeMapValueTransformerName")
    }
}


class TypeMapValueTransformer: ValueTransformer {

    override class func initialize() {
        let transformer = TypeMapValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName.typeMapValueTransformerName)
    }
    
    //转化器的类名
    override class func transformedValueClass() -> Swift.AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    //正向的转化接口
    override func transformedValue(_ value: Any?) -> Any? {
        let typeObj = value as! NSNumber
        let type = DBDataType(rawValue: typeObj.uintValue)
        return TypeMapValueTransformer.typeString(type!)
    }
    
    //反向的转化接口
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        let type = value as! String
        return NSNumber(value: (TypeMapValueTransformer.dataType(type)?.rawValue)!)
    }
    
    class func typeString(_ type: DBDataType) -> String? {
        let typeDic: Dictionary<DBDataType,String> = [.boolDataType:"Bool",
                                                      .stringDataType:"String",
                                                      .intDataType:"Int",
                                                      .dateDataType:"Date",
                                                      .blobDataType:"Blob"]
        return typeDic[type]
    }
    
    class func dataType(_ type: String) -> DBDataType? {
        let dateTypeDic: Dictionary<String,DBDataType> = ["Bool":.boolDataType,
                                                          "String":.stringDataType,
                                                          "Int": .intDataType,
                                                          "Date": .dateDataType,
                                                          "Blob": .blobDataType]
        return dateTypeDic[type]
    }
}
