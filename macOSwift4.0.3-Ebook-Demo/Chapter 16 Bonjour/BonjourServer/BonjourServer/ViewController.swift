//
//  ViewController.swift
//  BonjourServer
//
//  Created by iDevFans on 16/7/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let  kDomain = "local."
let  kServiceType = "_ProbeHttpService._tcp."
let  kServiceName = "myBonjourServer"
let  kServicePort: Int32 = 8888

class ViewController: NSViewController {
    
    var netService: NetService?
    override func viewDidLoad() {
        super.viewDidLoad()

        netService = NetService(domain: kDomain, type: kServiceType, name: kServiceName, port: kServicePort)
        
        netService?.delegate  = self
        
        netService?.schedule(in: RunLoop.current, forMode: .commonModes )
    
        netService?.publish()
    }

    
    func txtRecordData() -> Data {
        let data = "Send Data".data(using: String.Encoding.utf8)
        let txtRecordDictionary: [String:Data] = ["user":data!]
        return NetService.data(fromTXTRecord: txtRecordDictionary)
    }
    
}


func txtRecordData() -> Data {
    let data = "Send Data".data(using: String.Encoding.utf8)
    let txtRecordDictionary: [String:Data] = ["user":data!]
    return NetService.data(fromTXTRecord: txtRecordDictionary)
}

extension ViewController: NetServiceDelegate {
    
    func netServiceWillPublish(_ sender: NetService) {
        print("Service \(sender) Will Publish")
    }
    
    
    func netServiceDidPublish(_ sender: NetService) {
        print("Service \(sender) Did Publish")
        
        let sendData = self.txtRecordData()
        self.netService?.setTXTRecord(sendData)
    
    }
    
    
    func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        print("Service \(sender) didNot Publish ")
    }
    
}
