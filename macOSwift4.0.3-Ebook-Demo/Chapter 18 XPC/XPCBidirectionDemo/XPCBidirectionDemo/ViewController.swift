//
//  ViewController.swift
//  XPCBidirectionDemo
//
//  Created by iDevFans on 16/8/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    lazy var connection: NSXPCConnection = {
        //创建connection服务
        let connection = NSXPCConnection(serviceName: "macdev.io.DHelper")
        //注册协议接口
        connection.remoteObjectInterface = NSXPCInterface(with: HelperProtocol.self)
       
        connection.exportedInterface = NSXPCInterface(with: CallbackProtocol.self)
        connection.exportedObject = self
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
            (error) in print("remote proxy error:  \(error)")
            } as! HelperProtocol
        
        let testString = "abcd"
        
        //通过remoteObjectProxy执行xpc服务方法
        helper.upperCaseString!(aString: testString, withReply: {  upperString in print("\(upperString)")   })
        
    }
}

extension ViewController: CallbackProtocol {
    
    func logResultString(aString:String?) {
        print("Callback Result: \(aString)")
    }
}

