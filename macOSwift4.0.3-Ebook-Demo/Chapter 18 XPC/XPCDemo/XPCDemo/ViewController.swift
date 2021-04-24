//
//  ViewController.swift
//  XPCDemo
//
//  Created by iDevFans on 16/8/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    lazy var connection: NSXPCConnection = {
        //创建connection服务
        let connection = NSXPCConnection(serviceName: "macdev.io.Helper")
        //注册协议接口
        connection.remoteObjectInterface = NSXPCInterface(with: HelperProtocol.self)
        //同步等待连接建立
        connection.resume()
        return connection
    }()
    
    deinit {
        self.connection.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func convertAction(_ sender: NSButton) {
        
        //获取远程对象
        let helper = self.connection.remoteObjectProxyWithErrorHandler {
            (error) in print("remote proxy error: \(error)")
            } as! HelperProtocol
        
        let testString = "abcd"
        
        //通过remoteObjectProxy执行xpc服务方法
        helper.upperCaseString!(aString: testString, withReply: {  upperString in print("\(upperString)")   })
        
    }
}

