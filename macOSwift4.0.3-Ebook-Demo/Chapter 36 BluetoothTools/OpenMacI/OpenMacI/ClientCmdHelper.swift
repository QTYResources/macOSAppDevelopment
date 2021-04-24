//
//  ClientCmdHelper.swift
//  OpenMacI
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

let kCmdTypeKey  = "cmdType"
let kPasswordKey = "password"
let kStatusKey   = "status"
let kUsernameKey = "userName"

enum ClientCmdType : Int {
    case sleep = 0
    case wakeup
    case restart
    case shutdown
}

enum StatusType : Int {
    case sleep = 0
    case wakeup
    case shutdown
    case unknown
}

class ClientCmdHelper {
    
    class func wakeupCmdData() -> Data? {
        var opMap = [String : Any]()
        opMap[kCmdTypeKey] =  ClientCmdType.wakeup.rawValue
        opMap[kPasswordKey] = "1234"
        return opMap.jsonData()
    }
    
    class func sleepCmdData() -> Data? {
        var opMap = [String : Any]()
        opMap[kCmdTypeKey] = ClientCmdType.sleep.rawValue
        return opMap.jsonData()
    }
    
    class func restartCmdData() -> Data? {
        var opMap = [String : Any]()
        opMap[kCmdTypeKey] = ClientCmdType.restart.rawValue
        return opMap.jsonData()
    }
    
    class func shutdownCmdData() -> Data? {
        var opMap = [String : Any]()
        opMap[kCmdTypeKey] = ClientCmdType.shutdown.rawValue
        return opMap.jsonData()
    }
}
