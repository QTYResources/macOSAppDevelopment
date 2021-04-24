//
//  ViewController.swift
//  iCloud
//
//  Created by iDevFans on 16/8/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kKVkey: String  = "key1"

class ViewController: NSViewController {
    
    @IBOutlet weak var iCloudPathLabel: NSTextField!
    
    var fileManager: FileManager = FileManager.default
    var ubiquityContainer: URL?
    var ubiquityToken: AnyObject?
    var keyValueStore: NSUbiquitousKeyValueStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ubiquityToken = self.fileManager.ubiquityIdentityToken
        //不为空说明用户已经登录了iCloud帐号
        if ubiquityToken != nil {
            print("\(ubiquityToken)")
            self.keyValueStore = NSUbiquitousKeyValueStore.default
            self.keyValueStore?.set("value", forKey: kKVkey)
        }
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.ubiquityIdentityChanged(_:)),  name: NSNotification.Name.NSUbiquityIdentityDidChange , object: nil)
        
        //注册keyStore通知
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.storeDidChange(_:)),  name: NSUbiquitousKeyValueStore.didChangeExternallyNotification , object: NSUbiquitousKeyValueStore.default)
        
        //请求iCloud的Container
        self.requestICloudContainer()
        
    }
    
    func requestICloudContainer()  {
        let queue = DispatchQueue.global()
        queue.async {
            self.ubiquityContainer = self.fileManager.url(forUbiquityContainerIdentifier: nil)
            if self.ubiquityContainer == nil {
                print("No iCloud access");
            }
            else {
                print("iCloud access at \(self.ubiquityContainer)")
                self.keyValueStore?.synchronize()
                DispatchQueue.main.async{
                  self.iCloudPathLabel.stringValue = (self.documentsPath()?.absoluteString)!
                }
                self.listICloudFiles()
            }
        }
    }
    
    func documentsPath() -> URL? {
        if self.ubiquityContainer != nil {
            let url = self.ubiquityContainer?.appendingPathComponent("Documents")
            return url!
        }
        return nil
    }
    
    func listICloudFiles() {
        let path = self.documentsPath()?.path
        let enumeratedDirectory = self.fileManager.enumerator(atPath: path!)
        while let filename = enumeratedDirectory?.nextObject() {
            let pathStr = NSString(string: path!)
            let destURLString = pathStr.appendingPathComponent(filename as! String)
            print("\(destURLString)")
        }
    }
    
    @objc func ubiquityIdentityChanged(_ notification: Notification ) {
        let token = self.fileManager.ubiquityIdentityToken
        //为空说明用户退出了帐号
        if token == nil {
            self.showLogoutAlert()
        }
        else {
            //跟之前的不一样说明用户使用了另外一个账号登录
            if token?.hash != self.ubiquityToken?.hash {
                print("user has stayed logged in with same account")
            }
            else {
                print("user logged in with a new account")
            }
            self.ubiquityToken = token
        }
    }
    
    @objc func storeDidChange(_ notification: Notification ){
        self.keyValueStore?.synchronize()
        _ = self.keyValueStore?.object(forKey: kKVkey)
    }
    
    func uploadFile(){
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        openDlg.begin(completionHandler: { [weak self]  result in
            if(result.rawValue == NSFileHandlingPanelOKButton){
                let fileURLs = openDlg.urls
                let docPath = (self?.documentsPath())!
                for url:URL in fileURLs  {
                    let srcURL = url
                    let filename = url.lastPathComponent
                    let destURL = docPath.appendingPathComponent(filename)
                    
                    //为了避免文档处理阻塞主线程, 上面的代码使用后台线程
                    DispatchQueue.global().async {
                        
                        //为了减少多线程访问同一文件冲突，
                        //使用NSFileCoordinator做文件访问的管理控制
                        let fileCoordinator = NSFileCoordinator()
                        
                        fileCoordinator.coordinate(readingItemAt: srcURL, options: [.withoutChanges], error: nil, byAccessor: {
                        
                            newURL in
                            
                                print("\(newURL)")
                                _ = try? self?.fileManager.setUbiquitous(true, itemAt: srcURL, destinationURL: destURL)
                        })
                    }
                    return
                }
            }
        })
    }

    func showLogoutAlert() {
        let alert = NSAlert()
        //增加一个按钮
        alert.addButton(withTitle: "Ok")
        //提示的标题
        alert.messageText = "iCloud Logout"
        //提示的详细内容
        alert.informativeText = "User logout iCloud account"
        //设置告警风格
        alert.alertStyle = .informational
        alert .beginSheetModal(for: self.view.window!, completionHandler: { returnCode in
            //当有多个按钮是 可以通过returnCode区分判断
            print("returnCode :\(returnCode)")
            }
        )
    }
    
    @IBAction func uploadAction(_ sender: NSButton) {
        self.uploadFile()
    }
}


