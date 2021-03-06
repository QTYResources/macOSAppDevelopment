//
//  DataStoreBO.swift
//  SQLiteApp
//
//  Created by iDevFans on 16/9/6.
//  Copyright © 2016年 http://www.macdev.io All rights reserved.
//

import Cocoa

let kDefaultDatabaseName = "Chat.sqlite"

class DataStoreBO: NSObject {

    private static let  sharedInstance = DataStoreBO()
    class var shared: DataStoreBO {
        return sharedInstance
    }
    
    lazy var defaultDao: DAO = {
        let dao = DAO()
        return dao
    }()
    
    func openDefaultDB() -> Bool {
        return MDatabase.shared.openDBWithName(dbName: kDefaultDatabaseName)
    }
    
    func openDBWithPath(path: String) -> Bool {
        self.clear()
        let ret =  MDatabase.shared.openDBWithPath(dbPath: URL(fileURLWithPath:path))
        self.defaultDao = DAO()
        return ret
    }
    
    func clear() {
        MDatabase.shared.close()
    }
   
}
