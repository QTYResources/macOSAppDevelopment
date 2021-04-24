//
//  CmdManager.swift
//  OpenMacX
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation


class CmdManager {
    
    private static let  sharedInstance = CmdManager()
    class var shared: CmdManager {
        return sharedInstance
    }
    
    lazy var passwordCmdScript: String? = {
        let path = Bundle.main.path(forResource: "PasswordCmd", ofType: "strings")!
        guard let openCmd = try?  String(contentsOfFile: path)
            else {
                return nil
        }
        return openCmd
    }()
    
    lazy var sleepCmdScript: String? = {
        let path = Bundle.main.path(forResource: "SleepCmd", ofType: "strings")!
        guard let sleepCmd = try?  String(contentsOfFile: path)
            else {
                return nil
        }
        return sleepCmd
    }()
    
}
