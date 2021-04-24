//
//  XXXBonjourNetWorkManager.swift
//  XXXBonjourNetWork
//
//  Created by iDevFans on 16/10/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

enum XXXBonjourNetWorkBroadcastType : Int {
    case xxxBonjourNetWorkNilType = 0
    case xxxBonjourNetWorkFindService = 1
    case xxxBonjourNetWorkRemoveService = 2
    case xxxBonjourNetWorkResolveAddress = 3
    case xxxBonjourNetWorkNotResolveAddress = 4
    case xxxBonjourNetWorkStop = 5
}

let  kDomain = "local."
let  kServiceType = "_ProbeHttpService._tcp."

public class XXXBonjourNetWorkManager: NSObject {
    
    private static let  sharedInstance = XXXBonjourNetWorkManager()
    public class var shared: XXXBonjourNetWorkManager {
        return sharedInstance
    }
    
    lazy var serviceBrowser: NetServiceBrowser? = {
        let serviceBrowser = NetServiceBrowser()
        serviceBrowser.delegate = self
        return serviceBrowser
    }()
    var netServices: [NetService] = []
    
    public func start() {
        //开始服务发现
        self.serviceBrowser?.searchForServices(ofType: kServiceType, inDomain: kDomain)
        print("XXXBonjourNetWorkManager start")
        //测试桥接的 Objc 类
        Helper.show()
    }
    
    public func stop() {
        self.serviceBrowser?.stop()
    }
}

extension XXXBonjourNetWorkManager: NetServiceBrowserDelegate {
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        //保存发现的服务
        self.netServices.append(service)
        //设置服务代理
        service.delegate  = self
        //开始服务解析
        service.resolve(withTimeout: 2)
        print("didFindService \(service)")
    }
    
    
    public func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        var index: Int = 0
        var isExist: Bool = false
        for aService in self.netServices {
            if aService == service {
                isExist = true
                break
            }
            index = index + 1
        }
        
        if isExist {
            self.netServices.remove(at: index)
        }
    }
}


extension XXXBonjourNetWorkManager: NetServiceDelegate {
    
    public func netServiceDidResolveAddress(_ sender: NetService) {
        //完成解析,取得服务的host和port
        print("netServiceDidResolveAddress hostName \(sender.hostName) domain \(sender.domain)  port \(sender.port) name \(sender.name) ")
        sender.startMonitoring()
    }
    
    public func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didNotResolve error \(errorDict)")
    }
    
}
