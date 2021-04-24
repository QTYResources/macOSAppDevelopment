//
//  AppDelegate.swift
//  FMDBEncrypt
//
//  Created by iDevFans on 16/9/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


let kDBKEY          = "dfgdgf"
let kDBName         = "Database.sqlite"
let kDBEncryptName  = "DatabaseSwiftEn4.sqlite"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    public var handle: OpaquePointer? { return _handle }
    
    private var _handle: OpaquePointer?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let resourcePath = Bundle.main.resourcePath!
        let originalDBPath =  URL(fileURLWithPath: resourcePath).appendingPathComponent(kDBName).path
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let newPath =  URL(fileURLWithPath: paths[0]).appendingPathComponent(kDBEncryptName).path
        
        let sql  = " SELECT * FROM Person "
        
        if let db = FMDatabase.init(path: originalDBPath) {
            
            if !db.open() {
                return
            }
            //未加密的数据库表数据显示
            if let rs = try? db.executeQuery(sql,values: nil) {
                while rs.next() {
                     let jsonData = rs.resultDictionary()!
                     print(jsonData)
                }
            }
            
            if db.goodConnection() {
                // 关键流程 将未加密数据库内容导入一个新建的加密库
                let SQL = "ATTACH DATABASE  '\(newPath)' AS encrypted KEY '\(kDBKEY)' ;"
                if sqlite3_open(originalDBPath, &_handle) == SQLITE_OK {
                    sqlite3_exec(_handle,SQL,nil,nil,nil)
                    sqlite3_exec(_handle, "SELECT sqlcipher_export('encrypted');", nil, nil, nil);
                    sqlite3_exec(_handle, "DETACH DATABASE encrypted;", nil, nil, nil);
                   
                    sqlite3_close(_handle);
                    
                    print("newPath \(newPath)");
                }
                
                if let enDB = FMDatabase.init(path: newPath) {
                    if !enDB.open() {
                        return
                    }
                    else {
                        enDB.setKey(kDBKEY)
                    }
                    
                    if let rs = try? enDB.executeQuery(sql,values: nil) {
                        while rs.next() {
                            let jsonData = rs.resultDictionary()
                            print(jsonData)
                        }
                    }
                }
            }
        }
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}



