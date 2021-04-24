//
//  XXXPeripheralService.swift
//  OpenMacX
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import CoreBluetooth


protocol XXXPeripheralServiceDelegate: class  {
    func peripheralService(peripheralService: XXXPeripheralService, didRecieveWriteData data: Data?)
    
    func peripheralServiceSubscribeData(peripheralService: XXXPeripheralService) -> Data?
}
class XXXPeripheralService: NSObject {
    
    weak var delegate: XXXPeripheralServiceDelegate?
   
    lazy var peripheralManager: CBPeripheralManager = {
        return CBPeripheralManager(delegate: self, queue: nil)
    }()
    
    var characteristic :CBMutableCharacteristic?
    var peripheralIdentifier: String?
    var serviceID: String?
    var characteristicID: String?
    
    var notified: Bool {
        return true
    }
    
    lazy var serviceUUID :CBUUID = {
        return CBUUID(string: self.serviceID!)
    }()
    
    lazy var serviceUUIDs: [CBUUID] = {
        let serviceUUIDs = [self.serviceUUID]
        return serviceUUIDs
    }()
    
    lazy var characteristicUUID :CBUUID = {
        return CBUUID(string: self.characteristicID!)
    }()
    
    lazy var service: CBMutableService = {
        let s = CBMutableService(type: self.serviceUUID, primary: true)
        s.characteristics = [self.characteristic!]
        return s
    }()
    
    convenience init(serviceID: String, characteristicID: String) {
        self.init()
        self.serviceID = serviceID
        self.characteristicID = characteristicID
        self.configCharacteristic()
    }
    
    func configCharacteristic() {
        let data = "Start Data".data(using:String.Encoding.utf8)
        if(self.notified){
            self.characteristic =  CBMutableCharacteristic(type: self.characteristicUUID, properties:[.notify,.write], value:nil , permissions:.writeable )
        }
        else {
            self.characteristic =  CBMutableCharacteristic(type: self.characteristicUUID, properties: .read, value: data, permissions: .readable)
        }
    }
    
    func publishService() {
        self.stopService()
        self.peripheralManager.add(self.service)
    }
    
    func advertiseService() {
        var advertisementData: [String: Any] = [ CBAdvertisementDataServiceUUIDsKey: serviceUUIDs ]
        advertisementData[CBAdvertisementDataLocalNameKey] = self.peripheralIdentifier
        self.peripheralManager.startAdvertising(advertisementData)
    }
    
    
    func startService() {
        print("XXXPeripheralService Init State \(self.peripheralManager.state)")
    }
    
    func stopService() {
        self.disableService()
    }
    
    func nofifySubscribeData(data: Data) {
        
        let didSendValue = self.peripheralManager.updateValue(data, for: self.characteristic!, onSubscribedCentrals: nil)
        
        if didSendValue {
            print("notify ok!")
        }
    }
    
    
    func disableService() {
        self.peripheralManager.stopAdvertising()
        self.peripheralManager.remove(self.service)
    }
}



extension XXXPeripheralService: CBPeripheralManagerDelegate {

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        var stateDesc: String = "Bluetooth State Unknown"
        switch peripheral.state {
        case .unauthorized:
            stateDesc = "The platform/hardware doesn't support Bluetooth Low Energy"
            break
        case .unsupported:
            stateDesc = "The app is not authorized to use Bluetooth Low Energy"
            break
        case .poweredOff:
            stateDesc = "Bluetooth is currently powered off"
            break
        case .poweredOn:
            stateDesc = "Bluetooth is currently powered on"
            self.publishService()
            break
        default: break
            
        }
        print("\(stateDesc)")
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        guard error == nil else {
            print("Error didAddService: \(error!.localizedDescription)")
            return
        }
        self.advertiseService()
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        guard error == nil else {
            print("Error startAdvertising: \(error!.localizedDescription)")
            return
        }
        print("peripheralManager did advertising !")
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        
        if request.characteristic.uuid != self.characteristic?.uuid {
            return
        }
        print("didReceiveReadRequest\(peripheral)")
        
        if request.offset > (self.characteristic?.value?.count)! {
            peripheral.respond(to: request, withResult: .invalidAttributeValueLength)
            return
        }
        
        let start = request.offset
        let end = (self.characteristic?.value!.count)! - request.offset
        let range = Range(start...end)
        
        request.value = self.characteristic?.value?.subdata(in: range)
        peripheral.respond(to: request, withResult: .success)
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
        let request = requests[0]
        if request.characteristic.uuid != self.characteristic?.uuid {
            return
        }
        
        self.characteristic?.value = request.value
        
        peripheral.respond(to: request, withResult: .success)
        
        if let aDelegate =  self.delegate  {
            aDelegate.peripheralService(peripheralService: self, didRecieveWriteData: request.value)
        }
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        var data: Data?
        if let aDelegate =  self.delegate  {
            data = aDelegate.peripheralServiceSubscribeData(peripheralService: self)!
        }

        if data == nil {
            data = "Update Data".data(using: String.Encoding.utf8)
        }
        
        let didSendValue = peripheral.updateValue(data!, for: self.characteristic!, onSubscribedCentrals: nil)
        if didSendValue {
            print("didSubscribeToCharacteristic");
        }
        
    }
    
}



