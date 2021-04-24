//
//  HelperProtocol.swift
//  XPCDemo
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

@objc protocol HelperProtocol {
    @objc optional func upperCaseString(aString:String?, withReply: (String?)->Void )
}
