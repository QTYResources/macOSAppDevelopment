//
//  AppDelegate.swift
//  OpenMacX
//
//  Created by iDevFans on 16/9/4.
//  Copyright © 2016年 macdev. All rights reserved.
//





import Cocoa

let  kServiceUUID         = "84941CC5-EA0D-4CAE-BB06-1F849CCF8495"
let  kCharacteristicUUID  =  "2BCD"

let kCmdTypeKey  = "cmdType"
let kPasswordKey = "password"
let kStatusKey   = "status"
let kUsernameKey = "userName"

enum ClientCmdType : Int {
    case sleep = 0
    case wakeup
    case restart
    case shutdown
}

enum StatusType : Int {
    case sleep = 0
    case wakeup
    case shutdown
    case unknown
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var sysMenu: NSMenu!
    @IBOutlet weak var startMenu: NSMenuItem!
    @IBOutlet weak var stopMenu: NSMenuItem!
    
    var item: NSStatusItem?
    
    var isSleep = false
    var enableStartMenu = true
    var statusType: StatusType = .unknown
   
    lazy var userName: String = {
        let name = NSUserName()
        return name
    }()
    
    lazy var peripheralService: XXXPeripheralService = {
        let p = XXXPeripheralService(serviceID: kServiceUUID, characteristicID: kCharacteristicUUID)
        p.delegate = self
        p.peripheralIdentifier = self.userName
        return p
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        self.createStatusMenuBar()
        self.registerScreenStatusNotify()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        let statusBar = NSStatusBar.system
        statusBar.removeStatusItem(item!)
    }
    
    func createStatusMenuBar() {
        //获取系统单例NSStatusBar对象
        let statusBar = NSStatusBar.system
        //创建固定宽度的NSStatusItem
        item = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        item?.button?.image = NSImage(named: NSImage.Name(rawValue: "openMacIcon"))!
        //设置下拉菜单
        item?.menu = self.sysMenu
    }

    
    //MARK: Notification
    
    /// 注册系统睡眠和唤醒消息通知
    func registerScreenStatusNotify() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(self.recieveSleepNotification), name: NSWorkspace.screensDidSleepNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(self.recieveSleepNotification), name: NSWorkspace.screensDidWakeNotification, object: nil)
    }
    
    @objc func recieveSleepNotification(notification: NSNotification) {
        if (notification.name == NSWorkspace.screensDidSleepNotification) {
            self.statusType = .sleep
        }
        if (notification.name == NSWorkspace.screensDidWakeNotification) {
            self.statusType = .wakeup
        }
        self.sendSubscribeData()
    }
    
    
    func sendSubscribeData() {
        if let nofifyData = self.statusInfo().jsonData(){
            self.peripheralService.nofifySubscribeData(data: nofifyData)
        }
    }
    
    func statusInfo() -> [String : Any] {
        var statusInfo = [String : Any]()
        statusInfo[kUsernameKey] = self.userName
        statusInfo[kStatusKey]   = NSNumber.init(integerLiteral: self.statusType.rawValue)
        return statusInfo
    }
    
    //MARK: Menu Action
    
    
    @IBAction func startAction(_ sender: AnyObject) {
        print("startAction")
        self.peripheralService.startService()
        self.enableStartMenu = false
    }
    @IBAction func stopAction(_ sender: AnyObject) {
        print("stopAction")
        self.peripheralService.stopService()
        self.enableStartMenu = true
    }
    
    @IBAction func exitAction(_ sender: AnyObject) {
        NSApplication.shared.terminate(nil)
    }
    
    func validateMenuItem(menuItem: NSMenuItem) -> Bool {
        let action = menuItem.action
        if action == #selector(self.startAction) {
            return self.enableStartMenu
        }
        if action == #selector(self.stopAction) {
            return !self.enableStartMenu
        }
        return true
    }
    
    func inputPasswordScript(password: String) -> Bool {
        var scriptSource = CmdManager.shared.passwordCmdScript
        if password.characters.count > 0 {
            scriptSource = scriptSource?.replace(target:"%@", withString: password)
        }
        let appleScript = NSAppleScript(source: scriptSource!)
        
        var errDict: NSDictionary? = NSDictionary()
        let errObj: AutoreleasingUnsafeMutablePointer<NSDictionary?>? = AutoreleasingUnsafeMutablePointer<NSDictionary?>(&(errDict))
        
        let desc = appleScript?.executeAndReturnError(errObj)
        
        print("desc \(desc)  errObj = \(errObj)")
        
        return true

    }
    
    func wake() {
        let registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler")
        IORegistryEntrySetCFProperty(registryEntry, "IORequestIdle" as CFString!, kCFBooleanFalse)
        IOObjectRelease(registryEntry)
        
    }
    
    func sleep() {
        let registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler")
        
        IORegistryEntrySetCFProperty(registryEntry, "IORequestIdle" as CFString!, kCFBooleanTrue)
        IOObjectRelease(registryEntry)
        
    }

}

extension AppDelegate: XXXPeripheralServiceDelegate {

    func peripheralService(peripheralService: XXXPeripheralService, didRecieveWriteData data: Data?) {
        let cmdStr = String(data: data!, encoding: String.Encoding.utf8)
        print("didReceiveWriteRequests Data String = \(cmdStr) ")
        let cmdDict = cmdStr?.jsonObject()
        let cmdType = ClientCmdType.init(rawValue: cmdDict?[kCmdTypeKey] as! Int )
        
        if cmdType == .wakeup {
            self.wake()
            let password = cmdDict?[kPasswordKey] as! String
            let isOK = self.inputPasswordScript(password: password)
            if isOK {
                self.statusType = .wakeup
            }
            self.sendSubscribeData()
            return
        }
        if cmdType == .sleep {
            self.sleep()
            self.statusType = .sleep
            self.sendSubscribeData()
            return
        }
        if cmdType == .restart{
            MDSendAppleEventToSystemProcess(kAERestart)
        }
        if cmdType == .shutdown {
            MDSendAppleEventToSystemProcess(kAEShutDown)
        }
    }
    
    func peripheralServiceSubscribeData(peripheralService: XXXPeripheralService) -> Data? {
        let data = self.statusInfo().jsonData()
        return data
    }
}



func inputPasswordScript(password: String) -> Bool {
    var scriptSource = CmdManager.shared.passwordCmdScript
    if password.characters.count > 0 {
        scriptSource = scriptSource?.replace(target:"%@", withString: password)
    }
    let appleScript = NSAppleScript(source: scriptSource!)
    
    var errDict: NSDictionary? = NSDictionary()
    let errObj: AutoreleasingUnsafeMutablePointer<NSDictionary?>? = AutoreleasingUnsafeMutablePointer<NSDictionary?>(&(errDict))
    
    let desc = appleScript?.executeAndReturnError(errObj)
    
    print("desc \(desc)  errObj = \(errObj)")
    
    return true
    
}

func wake() {
    let registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler")
    IORegistryEntrySetCFProperty(registryEntry, "IORequestIdle" as CFString!, kCFBooleanFalse)
    IOObjectRelease(registryEntry)
    
}

func sleep() {
    let registryEntry = IORegistryEntryFromPath(kIOMasterPortDefault, "IOService:/IOResources/IODisplayWrangler")
    
    IORegistryEntrySetCFProperty(registryEntry, "IORequestIdle" as CFString!, kCFBooleanTrue)
    IOObjectRelease(registryEntry)
    
}
