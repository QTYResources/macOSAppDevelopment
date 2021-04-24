//
//  CallbackProtocol.swift
//  XPCBidirectionDemo
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

@objc protocol CallbackProtocol {
    @objc optional func logResultString(aString:String?)
}


