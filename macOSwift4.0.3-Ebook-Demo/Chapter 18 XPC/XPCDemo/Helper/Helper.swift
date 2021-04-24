//
//  Helper.swift
//  XPCDemo
//
//  Created by iDevFans on 16/8/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

class Helper: NSObject,HelperProtocol {
    
    func upperCaseString(aString:String?, withReply: (String?)->Void ) {
        let upperString = aString?.uppercased()
        withReply(upperString)
    }
}
