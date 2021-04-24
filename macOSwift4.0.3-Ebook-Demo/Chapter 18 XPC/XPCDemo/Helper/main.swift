//
//  main.swift
//  XPCDemo
//
//  Created by iDevFans on 16/8/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

class ServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
         //绑定服务接口
        newConnection.exportedInterface = NSXPCInterface(with: HelperProtocol.self)
        //创建服务实现类并且绑定到connection
        newConnection.exportedObject = Helper()
        //准备等待接口调用
        newConnection.resume()
        return true
    }
}
// 创建服务代理
let delegate = ServiceDelegate()
// 创建listener 准备监听服务请求
let listener = NSXPCListener.service()
//设置服务代理
listener.delegate = delegate;
// 启动服务监听.
listener.resume()
