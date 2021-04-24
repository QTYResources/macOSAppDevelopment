//
//  XXXCentralClient.swift
//  OpenMacI
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import CoreBluetooth



protocol XXXCentralClientDelegate: class {
    
    //搜索服务完成,获取到广播数据
    func centralClient(centralClient: XXXCentralClient, didRecieveAdvertisementData advertisementData: [String : Any])
    
    //接收到订阅数据
    func centralClient(centralClient: XXXCentralClient, didRecieveSubscribeData subscribData: Data)
    
    //Central开始跟对端Peripheral建立连接
    func didStartConnect(centralClient: XXXCentralClient)
    
    //连接完成
    func didCompleteConnect(centralClient: XXXCentralClient)
}
class XXXCentralClient: NSObject {
    weak var delegate: XXXCentralClientDelegate?
    
    lazy var centralManager: CBCentralManager = {
        return CBCentralManager(delegate: self, queue: nil)
    }()
    
    var peripheral: CBPeripheral?
    
    var serviceID: String?
    var characteristicID: String?

    var serviceUUID :CBUUID{
        return CBUUID(string: self.serviceID!)
    }
    var characteristicUUID :CBUUID{
        return CBUUID(string: self.characteristicID!)
    }
    
    var central: CBCentral?
    var service: CBService?
    var characteristic: CBCharacteristic?

    var notified: Bool {
        return true
    }
    
    convenience init(serviceID: String, characterisitcID: String) {
        self.init()
        self.serviceID = serviceID
        self.characteristicID = characterisitcID
    }
    
    //蓝牙上电后开始扫描service
    func scan() {
        self.centralManager.scanForPeripherals(withServices: [self.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
        print("centralManager begin scan \(self.serviceUUID)")
    }
    
    //ping 服务,防止蓝牙连接断开
    func pingService() {
        self.scan()
    }
    
    //启动
    func start() {
         print("centralManager init state \(self.centralManager.state)")
    }
   
    //发送数据，即写数据对对端
    func write(data: Data) {
        if self.service == nil {
            print("writeData No connected services for peripheralat!")
            return
        }
        self.peripheral?.writeValue(data, for: self.characteristic!, type: .withResponse)
    }
}

extension XXXCentralClient: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var stateDesc = "State Unknown"
        switch central.state {
        case .poweredOff:
            stateDesc = "State PoweredOff"
            break
        case .poweredOn:
            stateDesc = "State PoweredOn"
            self.scan()
            break
        case .unsupported:
            stateDesc = "State Unsupported"
            break
        case .unauthorized:
            stateDesc = "State Unauthorized"
            break
        case .resetting:
            stateDesc = "State Resetting"
            break
        default:
            break
        }
        
        print("centralManager \(stateDesc)")
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print("didDiscover \(peripheral) advertisementData:\(advertisementData)")
        central.stopScan()
        self.peripheral = peripheral;
        
        self.delegate?.centralClient(centralClient: self, didRecieveAdvertisementData: advertisementData)
        
        //开始连接
        central.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey:true])
        
        self.delegate?.didStartConnect(centralClient: self)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("didConnect")
        peripheral.delegate = self;
        peripheral.discoverServices([self.serviceUUID])
        
    }

    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        guard error == nil else {
            print("Error didFailToConnect: \(error!.localizedDescription)")
            self.scan()
            return
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnectPeripheral")
        self.scan()
    }
    
}


extension XXXCentralClient: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            print("Error didDiscoverServices: \(error!.localizedDescription)")
            return
        }
        
        for service in peripheral.services! {
            print("discovered service \(service)")
            print("start discovering characteristics for service \(service)")
            if service.uuid.uuidString == self.serviceID {
                peripheral.discoverCharacteristics([characteristicUUID], for: service)
                self.service = service
                print("discovered my service \(service)")
                break
            }
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            print("Error didDiscoverCharacteristicsFor: \(error!.localizedDescription)")
            return
        }
        
        for characteristic in service.characteristics! {
            
            if characteristic.uuid.uuidString == characteristicID {
               
                self.characteristic = characteristic;
                
                if(notified){
                    peripheral.setNotifyValue(true, for: characteristic)
                }
                else {
                    peripheral.readValue(for: characteristic)
                }
                
                self.delegate?.didCompleteConnect(centralClient: self)
                print("discovered my characteristic \(characteristic)")
                break
            }
            
        }
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else {
            print("Error didUpdateValueFor: \(error!.localizedDescription)")
            return
        }
        
        let data = characteristic.value
        let value = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("Reading value: \(value)")
        self.delegate?.centralClient(centralClient: self, didRecieveSubscribeData: data!)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else {
            print("Error didWriteValueFor: \(error!.localizedDescription)")
            return
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        guard error == nil else {
            print("Error didUpdateNotificationStateFor: \(error!.localizedDescription)")
            return
        }
        
        let data = characteristic.value
        if let data = data {
            let value = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print("Notification value: \(value)")
            
            self.delegate?.centralClient(centralClient: self, didRecieveSubscribeData: data)
        }
        
    }
    
}





