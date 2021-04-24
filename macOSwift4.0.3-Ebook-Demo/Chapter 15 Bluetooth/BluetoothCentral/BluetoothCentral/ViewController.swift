//
//  ViewController.swift
//  BluetoothCentral
//
//  Created by iDevFans on 16/7/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import CoreBluetooth

let kServiceUUID: String = "84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
let kCharacteristicUUID: String = "2BCD"


class ViewController: NSViewController {
    var centralManager: CBCentralManager?
    var serviceUUID: CBUUID = CBUUID(string: kServiceUUID)
//    var serviceUUID :CBUUID{
//        return CBUUID(string: kServiceUUID)
//    }
    
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
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didRetrievePeripherals peripherals: [CBPeripheral]) {
        
        
        print("didRetrievePeripherals")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
        print("didFailToConnect")
    }
    
}
