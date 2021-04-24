//
//  ViewController.swift
//  BluetoothCentralIPhone
//
//  Created by iDevFans on 16/7/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import UIKit
import CoreBluetooth

let kServiceUUID: String = "84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
let kCharacteristicUUID: String = "2BCD"

class ViewController: UIViewController {
    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral?
    var serviceUUID :CBUUID{
        return CBUUID(string: kServiceUUID)
    }
    var characteristicUUID :CBUUID{
        return CBUUID(string: kCharacteristicUUID)
    }
    
    var notified: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scan() {
        self.centralManager?.scanForPeripherals(withServices: [self.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey:true])
        print("centralManager begin scan \(self.serviceUUID)")
    }

}


extension ViewController: CBCentralManagerDelegate {
    
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
        
        //开始连接
        central.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey:true])
    }
    
    
    func centralManager(_ central: CBCentralManager, didRetrievePeripherals peripherals: [CBPeripheral]) {
        print("didRetrievePeripherals")
    }
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("didConnect")
        peripheral.delegate = self;
        peripheral.discoverServices([self.serviceUUID])

    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        guard error == nil else {
            print("Error didFailToConnect: \(error!.localizedDescription)")
            return
        }
    }
    
}


extension ViewController: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            print("Error didDiscoverServices: \(error!.localizedDescription)")
            return
        }
        
        for service in peripheral.services! {
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
            print("discovered service \(service)")
            print("start discovering characteristics for service \(service)")
        }
    }

    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            print("Error didDiscoverCharacteristicsFor: \(error!.localizedDescription)")
            return
        }
        
        for characteristic in service.characteristics! {
            if(notified){
                peripheral.setNotifyValue(true, for: characteristic)
            }
            else {
                peripheral.readValue(for: characteristic)
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
        }
        
    }
    
}




