//
//  Helper.swift
//  XPCBidirectionDemo
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

class Helper: NSObject,HelperProtocol {
    weak var connection: NSXPCConnection?
    func upperCaseString(aString:String?, withReply: (String?)->Void ) {
        let upperString = aString?.uppercased()
        withReply(upperString)
        
        //获取远程对象
        let callback = self.connection?.remoteObjectProxyWithErrorHandler {
            (error) in print("remote proxy error: \(error)")
            } as! CallbackProtocol
        callback.logResultString!(aString:upperString)
    }
}
