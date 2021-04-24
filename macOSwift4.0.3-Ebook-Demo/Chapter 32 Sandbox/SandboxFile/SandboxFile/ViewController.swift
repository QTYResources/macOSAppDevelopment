//
//  ViewController.swift
//  SandboxFile
//
//  Created by iDevFans on 16/8/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kFilePath: String = "kFilePath"

typealias FilePermissionBlock = () -> Void

class ViewController: NSViewController {

    @IBOutlet weak var filePathField: NSTextField!
    @IBOutlet var textView: NSTextView!
    var filePathURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //从UserDefaults获取文件路径
        let defaults = UserDefaults.standard
        let fileURL = defaults.value(forKey: kFilePath) as? String
        let url = URL.init(string: fileURL!)
       
        //从UserDefaults获取文件Bookmark
        
        _ = self.accessFileURL(ofURL: url!, withBlock: {
            
            //如果能从url路径中读取内容，则把文件路径和内容更新到界面控件
            guard let string = try?  NSString.init(contentsOf: url!, encoding: String.Encoding.utf8.rawValue)
                else {
                    //获取失败则不进行后续的处理
                    return
            }
            //存储url路径到本地属性变量
            self.filePathURL = url
            //更新UI控件
            self.filePathField.stringValue = fileURL!
            self.textView.string = string as String
            
            }
        )
   
    }
    


    
    @IBAction func openFileAction(_ sender: NSButton) {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["txt","strings"]
        
        openDlg.begin(completionHandler: { [weak self]  result in
            
            if(result.rawValue == NSFileHandlingPanelOKButton){
                let fileURLs = openDlg.urls
                //返回的结果是数组，实际上只有一个元素
                for url:URL in fileURLs  {
                    guard let string = try?  NSString.init(contentsOf: url as URL, encoding: String.Encoding.utf8.rawValue)
                        else {
                            return
                    }
                    self?.filePathField.stringValue = url.absoluteString
                    self?.textView.string = string as String
                    self?.filePathURL = url
                    
                    let defaults = UserDefaults.standard
                    defaults.set(url.absoluteString, forKey: kFilePath)
                    //同步保存数据
                    defaults.synchronize()
                    self?.persistPermissionURL(url)
                    
                   
                    
                }
            }
        })
    }

    @IBAction func saveFileAction(_ sender: NSButton) {
        //获取textview的内容
        let text = self.textView.string
        
        _ = self.accessFileURL(ofURL: self.filePathURL!, withBlock: {
            
            //写入文件，捕获异常处理使用try？
            _ = try? text.write(to: self.filePathURL!, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            
            }
        )
    }
    
    
    func persistPermissionURL(_ url:URL) {
        //根据url生产bookmarkData
        let bookmarkData = try?  url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
        
        print("persistPermissionURL bookmarkData\(url) \(bookmarkData)")
        //存储bookmarkData
        if let bookmarkData = bookmarkData {
            let defaults = UserDefaults.standard
            defaults.setValue(bookmarkData, forKey: url.path)
            defaults.synchronize()
        }
    }
    
    
    func accessFileURL(ofURL url: URL , withBlock block:FilePermissionBlock) -> Bool {
        
        let defaults = UserDefaults.standard
        let bookmarkData = defaults.value(forKey: url.path) as? Data
        
        if let bookmarkData = bookmarkData {
            var bookmarkDataIsStale: Bool = false
            let allowedUrl = try! URL(resolvingBookmarkData: bookmarkData, options:[.withoutUI,.withSecurityScope], relativeTo: nil, bookmarkDataIsStale: &bookmarkDataIsStale)
            //bookmarkDataIsStale返回为true时需要重新创建bookmarkData
            if bookmarkDataIsStale  {
                self.persistPermissionURL(url)
            }
            if (allowedUrl?.startAccessingSecurityScopedResource())! {
                block()
                allowedUrl?.stopAccessingSecurityScopedResource()
                return true
            }
        }
        return false
    }
}

if let bookmarkData = bookmarkData {
    let defaults = UserDefaults.standard
    defaults.setValue(bookmarkData, forKey: url.path)
    defaults.synchronize()
}

