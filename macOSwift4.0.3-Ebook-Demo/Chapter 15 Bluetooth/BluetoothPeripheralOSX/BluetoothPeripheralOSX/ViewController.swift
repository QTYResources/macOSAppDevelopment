//
//  ViewController.swift
//  BluetoothPeripheralOSX
//
//  Created by iDevFans on 16/7/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import CoreBluetooth

let kServiceUUID: String = "84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
let kCharacteristicUUID: String = "2BCD"

class ViewController: NSViewController {
    
    @IBOutlet weak var textFiled: NSTextField!
    var peripheralManager: CBPeripheralManager?
    var characteristic :CBMutableCharacteristic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCharacteristic()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil)

    }
    
    
    var notified: Bool {
        return true
    }
    
    var serviceUUID :CBUUID{
        return CBUUID(string: kServiceUUID)
    }
    
    var serviceUUIDs: [CBUUID] {
        let serviceUUIDs = [self.serviceUUID]
        return serviceUUIDs
    }
    
    var characteristicUUID :CBUUID{
        return CBUUID(string: kCharacteristicUUID)
    }
    
    
    var service :CBMutableService{
        let s = CBMutableService(type: serviceUUID, primary: true)
        s.characteristics = [self.characteristic!]
        return s
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
    
    
    @IBAction func notifyValueAction(_ sender: NSButton) {
    
        let notifyStr = self.textFiled.stringValue
        
        let data = notifyStr.data(using:String.Encoding.utf8)
        
        let didSendValue = self.peripheralManager?.updateValue(data!, for: self.characteristic!, onSubscribedCentrals: nil)
        
        
        if (didSendValue != nil) {
            print("notify ok!")
        }
    }
    
    func publishService() {
        self.peripheralManager?.remove(self.service)
        self.peripheralManager?.add(self.service)
    }
    
    func advertiseService() {
        var advertisementData: [String: Any] = [ CBAdvertisementDataServiceUUIDsKey: serviceUUIDs ]
        advertisementData[CBAdvertisementDataLocalNameKey] = "RadioChannel"
        self.peripheralManager?.startAdvertising(advertisementData)
    }
}



extension ViewController: CBPeripheralManagerDelegate {
    
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
        
    }
    
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
        let data = "Update Data".data(using: String.Encoding.utf8)
        let didSendValue = peripheral.updateValue(data!, for: self.characteristic!, onSubscribedCentrals: nil)
        if didSendValue {
            print("didSubscribeToCharacteristic");
        }
    }
    
}




