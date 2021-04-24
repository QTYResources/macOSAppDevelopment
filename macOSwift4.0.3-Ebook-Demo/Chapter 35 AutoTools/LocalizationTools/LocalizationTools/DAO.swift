//
//  DAO.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class DAO: NSObject {

    var tableName = "" /*table name*/
    
    var fldList = [String]() /*all coulumn list*/
    
    var keyList = [String]()  /*primary key coulumn list*/
    
    var fldExcludeKeyList = [String]() /*coulumn list */
    
    var recordsNum: Int = 0
    
    weak var queue: FMDatabaseQueue?
    
    
    override required init() {
        super.init()
        self.queue = MDatabase.shared.queue
    }
    
    func numbersOfRecord() -> Int {
        if tableName.characters.count <= 0 {
            return 0
        }
        let sql = "SELECT count(*) as count FROM \(tableName)"
        
        self.queue?.inDatabase({ db in
            var rs: FMResultSet?
            do {
                rs = try db!.executeQuery(sql,values: nil)
                self.recordsNum = 0
                if rs!.next() {
                    self.recordsNum = Int(rs!.int(forColumnIndex: 0))
                }
                rs!.close()
            }
            catch let error {
                print("error \(error)")
                return
            }
        })
        
        return recordsNum
    }
    
    
    func pageNumberWithSize(pageSize: Int) -> Int {
        if tableName.characters.count <= 0 {
            return 0
        }
        guard pageSize > 0 else {
            print("invalid pageSize")
            return 0
        }
        let sql = "SELECT count(*) as count FROM \(tableName)"
        var pageNumber = 0
        self.queue?.inDatabase({ db in
            var rs: FMResultSet?
            do {
                rs = try db!.executeQuery(sql,values: nil)
            }
            catch let error {
                print("error \(error)")
                return
            }
            self.recordsNum = 0
            if rs!.next() {
                self.recordsNum = Int(rs!.int(forColumnIndex: 0))
            }
            rs!.close()
            if self.recordsNum > 0 {
                pageNumber = Int(ceil(Double(self.recordsNum / pageSize)))
            }
        })
        return pageNumber
    }
    
    func numbersOfRecordWithSQL(sql: String) -> Int {
        
        var count = 0
        
        let queryTemp = sql.lowercased()
        
        let matchedTableName = queryTemp.matchedSQLTableName()
        
        guard  let tableName = matchedTableName else {
            return 0
        }
        
        let countSQL = "SELECT COUNT(*) as count FROM \(tableName)"
        
        self.queue?.inDatabase({ db  in
            
            var rs: FMResultSet?
            do {
                rs = try db!.executeQuery(countSQL,values: nil)
            }
            catch let error {
                print("error \(error)")
                return
            }
            if rs!.next() {
                count = Int(rs!.int(forColumnIndex: 0))
            }
            rs!.close()
        })
        return count
    }
    
    func pageNumberWithSQL(sql: String, pageSize: Int) -> Int {
        guard pageSize > 0 else {
            print("invalid pageSize")
            return 0
        }
        var pageNumber = 0
        self.queue?.inDatabase({ db in
            let rs = try? db!.executeQuery(sql,values: nil)
            var count = 0
            if rs!.next() {
                count = Int(rs!.int(forColumnIndex: 0))
            }
            rs!.close()
            if count > 0 {
                pageNumber = Int(ceil(Double(count / pageSize)))
            }
        })
        return pageNumber
    }
    
    func insert(model: AnyObject) -> Bool {
        let keyCount = keyList.count
        if keyCount == 0 {
            return false
        }
        if keyCount > 0 {
            let key = keyList[0]
            var keyID = (model.value(forKey: key) as! NSNumber).intValue
            if keyID == 0 {
                keyID = findMaxKey() + 1
                model.setValue(keyID, forKey: key)
            }
            else {
                if findBy(model: model) != nil {
                    print("info:add \(tableName) exsist!\n")
                    return update(model: model)
                }
            }
        }
        var vals = String()
        let fieldCount = fldList.count
        for i in 0..<fieldCount {
            if i != fieldCount - 1 {
                vals += "?,"
            }
            else {
                vals += "?"
            }
        }
        let fieldString = fldList.joined(separator: ",")
        let sql = "INSERT INTO \(tableName) (\(fieldString)) VALUES ( \(vals) )"
        print("insert sql= \(sql)")
        var args = [AnyObject]()
        for mapkey in fldList{
            let value = model.value(forKey: mapkey)
            args.append(value! as AnyObject)
        }
        var isOK = false
        self.queue?.inDatabase({ db  in
            isOK = db!.executeUpdate(sql, withArgumentsIn: args)
            print("insert lastErrorMessage \(db!.lastErrorMessage())")
        })
        return isOK
    }
    
    
    func update(model: AnyObject) -> Bool {
        
        if (findBy(model: model) == nil) {
            print("info:no exsist update Model!")
            return false
        }
        var wheres = String()
        let keyCount = keyList.count
        var fieldVals = String()
        var args = [AnyObject]()
        let fieldCount = fldExcludeKeyList.count
        
        for i in 0..<fieldCount {
            let fName = fldExcludeKeyList[i]
            if i != fieldCount - 1 {
                fieldVals += String(format: "%@ = ? , ", fName)
            }
            else {
                fieldVals += String(format: "%@ = ? ", fName)
            }
            let value = model.value(forKey: fName)
            args.append(value as AnyObject)
        }
        
        if fieldCount <= 0 {
            for i in 0..<keyCount {
                let fName = keyList[i]
                if i != keyCount - 1 {
                    fieldVals += String(format: "%@ = ? , ", fName)
                }
                else {
                    fieldVals += String(format: "%@ = ? ", fName)
                }
                let value = model.value(forKey: fName)
                args.append(value as AnyObject)
            }
        }
        
        for i in 0..<keyCount {
            let fName = keyList[i]
            if i != keyCount - 1 {
                wheres += String(format: "%@ = ? AND ", fName)
            }
            else {
                wheres += String(format: "%@ = ? ", fName)
            }
            let value = model.value(forKey: fName)
            args.append(value as AnyObject)
        }
        let sql = "UPDATE \(tableName) SET \(fieldVals) WHERE \(wheres)"
        print("update sql=\(sql)")
        var isOK = false
        self.queue?.inDatabase({ db in
            isOK = db!.executeUpdate(sql, withArgumentsIn: args)
            print("update lastErrorMessage \(db?.lastErrorMessage())")
        })
        return isOK
    }
    
    
    func delete(model: AnyObject) -> Bool {
        var wheres = String()
        let keyCount = keyList.count
        var args = [AnyObject]()
        var i = 0
        for keyName in keyList {
            if i != keyCount - 1 {
                wheres += String(format: "%@ = ? AND ", keyName)
            }
            else {
                wheres += String(format: "%@ = ? ", keyName)
            }
            let value = model.value(forKey: keyName)
            args.append(value as AnyObject)
            i = i + 1
        }
        let sql = "DELETE FROM  \(tableName) WHERE \(wheres) "
        print("delete sql=%@", sql)
        var isOK = false
        self.queue?.inDatabase({ db in
            isOK = db!.executeUpdate(sql, withArgumentsIn: args)
            print("delete lastErrorMessage \(db?.lastErrorMessage())")
        })
        return isOK
    }
    
    func removeAll() -> Bool {
        let sql = "DELETE FROM  \(tableName) "
        print("clearAll sql= \(sql)")
        return sqlUpdate(sql: sql)
    }
    
    func sqlUpdate(sql: String) -> Bool {
        return sqlUpdate(sql: sql, withArgumentsIn: nil)
    }
    
    func sqlUpdate(sql: String, withArgumentsIn args: [AnyObject]?) -> Bool {
        var isOK = false
        self.queue?.inDatabase({ db in
            isOK = db!.executeUpdate(sql, withArgumentsIn: args!)
        })
        return isOK
    }
    
    func sqlUpdate(sql: String, withParameterDictionary dics: [NSObject : AnyObject]?) -> Bool {
        var isOK = false
        self.queue?.inDatabase({ db in
            isOK = db!.executeUpdate(sql, withParameterDictionary: dics!)
        })
        return isOK
    }
    
    func sqlQuery(sql: String) -> [AnyObject]? {
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db in
            let rs = try? db!.executeQuery(sql,values: nil)
            while rs!.next() {
                let jsonData = rs!.resultDictionary()
                modles.append(jsonData as AnyObject)
            }
            rs!.close()
        })
        return modles
    }
    
    func sqlQuery(sql: String, pageIndex: Int, pageSize: Int) -> [AnyObject]? {
        let finalSQL = " \(sql)  LIMIT \(pageSize) OFFSET \(pageSize * pageIndex) "
        return sqlQuery(sql: finalSQL)
    }
    
    func sqlQuery(sql: String, withArgumentsIn args: [AnyObject]) -> [AnyObject]? {
        if args.count == 0 {
            return sqlQuery(sql: sql)
        }
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db in
            let rs = db!.executeQuery(sql, withArgumentsIn: args)
            while rs!.next() {
                let jsonData = rs!.resultDictionary()
                modles.append(jsonData! as AnyObject)
            }
            rs!.close()
        })
        return modles
    }
    
    func sqlQuery(sql: String, withParameterDictionary dics: [NSObject : AnyObject]) -> [AnyObject]? {
        let count = dics.keys.count
        if  count == 0 {
            return sqlQuery(sql:sql)
        }
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db  in
            let rs =  db!.executeQuery(sql, withParameterDictionary: dics)
            while rs!.next() {
                let jsonData = rs!.resultDictionary()
                modles.append(jsonData! as AnyObject)
            }
            rs!.close()
        })
        return modles
    }
    
    
    func findAll() -> [AnyObject]? {
        let sql = "SELECT * FROM  \(tableName)  "
        print("findAll sql= \(sql)")
        return sqlQuery(sql: sql)
    }
    
    
    func findBy(model: AnyObject) -> AnyObject? {
        let keyCount = keyList.count
        if keyCount <= 0 {
            print("table no primary key field!")
            return nil
        }
        var kv = [String : AnyObject]()
        for k in keyList {
            let v = model.value(forKey: k)
            kv[k] = v as AnyObject?
        }
        return findBy(kv: kv)
    }
    
    func findBy(kv: [String : AnyObject]) -> AnyObject? {
        var datas = findByAttributes(attributes: kv)!
        if datas.count > 0 {
            return datas[0]
        }
        return nil
    }
    
    func findByAttributes(attributes: [String : AnyObject]) -> [AnyObject]? {
        var wheres = String()
        let  keyCount = attributes.keys.count
        if keyCount <= 0 {
            print("findByAttributes :  attribute parameter is null  !")
            return nil
        }
        var i = 0
        for fName in attributes.keys {
            if i != keyCount - 1 {
                wheres += String(format: "%@ = :%@ AND ", fName, fName)
            }
            else {
                wheres += String(format: "%@ = :%@ ", fName, fName)
            }
            i = i + 1
        }
        let sql = "SELECT * FROM  \(tableName)  WHERE \(wheres) "
        print("findByAttributes sql=\(sql)")
        return sqlQuery(sql:sql, withParameterDictionary: attributes as [NSObject : AnyObject])
    }
    
    func findByPage(pageIndex: Int, pageSize: Int) -> [AnyObject]? {
        let sql = "SELECT * FROM  \(tableName)  LIMIT \(pageSize) OFFSET \(pageSize * pageIndex) "
        print("findByPage sql=\(sql) pageindex=\(pageIndex)")
        return sqlQuery(sql: sql)
    }
    
    
    func findMaxKey() -> Int {
        let keyCount = keyList.count
        if keyCount <= 0 {
            print("table no primary key field!")
            return 1
        }
        let sql = "SELECT max(\(keyList[0])) FROM  \(tableName)  "
        print("findMaxKey sql=\(sql)")
        var rs: FMResultSet?
        self.queue?.inDatabase({ db in
            rs = try! db?.executeQuery(sql,values: nil)
        })
        var maxValue = 1
        if rs!.next() {
            maxValue = Int(rs!.int(forColumnIndex: 0))
        }
        rs!.close()
        return maxValue
    }
    
}

