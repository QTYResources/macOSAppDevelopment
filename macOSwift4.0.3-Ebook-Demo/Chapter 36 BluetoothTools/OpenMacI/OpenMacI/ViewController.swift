//
//  ViewController.swift
//  OpenMacI
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//




import UIKit
import CoreBluetooth

let  kServiceUUID         =  "84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
let  kCharacteristicUUID  = "2BCD"

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var shutdownButton: UIButton!

    @IBOutlet weak var hostNameLabel: UILabel!
   
    var isMacSleep = false
    //标记Mac是否处于休眠态
    @IBOutlet weak var macImageView: UIImageView!
    
    lazy var centralClient: XXXCentralClient = {
        let client = XXXCentralClient(serviceID: kServiceUUID, characterisitcID: kCharacteristicUUID)
        client.delegate = self
        return client
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicatorView.startAnimating()
        self.lockButton.isHidden = true
        self.restartButton.isHidden = true
        self.shutdownButton.isHidden = true
        self.hostNameLabel.text = ""
        self.isMacSleep = false
        self.centralClient.start()
    }

    @IBAction func lockAction(_ sender: AnyObject) {
        var CmdData = ClientCmdHelper.sleepCmdData()
        if self.isMacSleep {
            CmdData = ClientCmdHelper.wakeupCmdData()
        }
        self.centralClient.write(data: CmdData!)
        self.centralClient.pingService()
    }
    
    @IBAction func restartAction(_ sender: AnyObject) {
        let CmdData = ClientCmdHelper.restartCmdData()
        self.centralClient.write(data: CmdData!)
        self.centralClient.pingService()
    }
    
    @IBAction func shutdownAction(_ sender: AnyObject) {
        let CmdData = ClientCmdHelper.shutdownCmdData()
        self.centralClient.write(data:CmdData!)
        self.centralClient.pingService()
    }
}


extension ViewController: XXXCentralClientDelegate {

    func centralClient(centralClient: XXXCentralClient, didRecieveAdvertisementData advertisementData: [String : Any]) {
        let userName = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if userName != "" {
            self.hostNameLabel.text = userName
            let image = UIImage(named: "MacColor")!
            self.macImageView.image = image
        }
    }
    
    func centralClient(centralClient: XXXCentralClient, didRecieveSubscribeData subscribData: Data) {
        let dataDict = subscribData.jsonObject()
        if dataDict == nil {
            return
        }
        let status = StatusType(rawValue: Int(dataDict?[kStatusKey] as! NSNumber))!
        print("status dataDict \(dataDict) ")
        if status == .wakeup && self.isMacSleep {
            self.isMacSleep = false
            self.lockButton.titleLabel?.text = "  Lock  "
        }
        if status == .sleep && !self.isMacSleep {
            self.isMacSleep = true
            self.lockButton.titleLabel?.text = "Unlock"
        }
    }
    
    func didStartConnect(centralClient: XXXCentralClient) {
        self.statusLabel.text = "Connecting..."
    }
    
    func didCompleteConnect(centralClient: XXXCentralClient) {
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.isHidden = true
        self.statusLabel.isHidden = true
        self.lockButton.isHidden = false
        self.restartButton.isHidden = false
        self.shutdownButton.isHidden = false
    }

}

