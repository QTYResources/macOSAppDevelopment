//
//  ViewController.swift
//  BonjourClient
//
//  Created by iDevFans on 16/7/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let  kDomain = "local."
let  kServiceType = "_ProbeHttpService._tcp."

class ViewController: NSViewController {

    var serviceBrowser: NetServiceBrowser?
    var netServices: [NetService] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceBrowser = NetServiceBrowser()
        self.serviceBrowser?.delegate = self
        self.start()
    }
    
    func start() {
        //开始服务发现
        self.serviceBrowser?.searchForServices(ofType: kServiceType, inDomain: kDomain)
    }
    
    func stop() {
        self.serviceBrowser?.stop()
    }

}



extension ViewController: NetServiceBrowserDelegate {
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        //保存发现的服务
        self.netServices.append(service)
        //设置服务代理
        service.delegate  = self
        //开始服务解析
        service.resolve(withTimeout: 2)
        print("didFindService \(service)")
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
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



extension ViewController: NetServiceDelegate {
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        //完成解析,取得服务的host和port
        print("netServiceDidResolveAddress hostName \(sender.hostName) domain \(sender.domain)  port \(sender.port) name \(sender.name) ")
        sender.startMonitoring()
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("didNotResolve error \(errorDict)")
    }

    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        let infoDict = NetService.dictionary(fromTXTRecord: data)
        let data = infoDict["user"]! as Data
        let str = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print("didUpdateTXTRecordData \(str)");
    }

}
