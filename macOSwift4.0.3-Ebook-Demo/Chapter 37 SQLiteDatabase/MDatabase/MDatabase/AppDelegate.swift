//
//  AppDelegate.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/28.
//  Copyright © 2016年 macdev. All rights reserved.
//



import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        
        
        let engine = DMTemplateEngine()
        //加载模版
        engine.template = "Hello, my name is {% firstName %}."
        
        var templateData = [String : AnyObject]()
        //参数设置
        templateData["firstName"] = "Dustin" as AnyObject?
        //渲染
        let str = engine.renderAgainst(templateData)
        
        print("str \(str)")
        
        self.dbTest()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    func dbTest() {
        let path = "/Users/idevfans/Documents/DatabaseDemo.sqlite"
        let fileManager = FileManager.default
        let success = fileManager.fileExists(atPath: path)
        //如果路径不存在 则返回
        if !success {
           return
        }

        let sql = "select * from Person"
        
        if let db = FMDatabase.init(path: path) {
            //判断是否可以正常打开数据库
            if !db.open() {
                return
            }
           
            
            //数据查询
            if let rs = try? db.executeQuery(sql,values: nil) {
                while rs.next() {
                    //获取key-value json格式数据
                    let jsonData = rs.resultDictionary()
                    
                    //根据列名称获取
                    let name = rs.string(forColumn: "name")
                    let age = rs.int(forColumn: "age")
                    
                    
                    //根据表列顺序获取
                    let name1 = rs.string(forColumnIndex: 0)
                    let age1 = rs.int(forColumnIndex: 1)
                   
                }
                rs.close()
            }
            
            
            //增加数据
            let updateSQL = "insert into Person values ('jhon',10)"
            
            var isOK = false
            isOK = db.executeUpdate(updateSQL,withArgumentsIn: nil)
            if !isOK {
                print("insert data failed!")
            }
            
            //删除数据
            let deleteSQL = "delete from Person where age > 40"
            
            isOK = db.executeUpdate(deleteSQL,withArgumentsIn: nil)
            if !isOK {
                print("delete data failed!")
            }
            
            db.close()
        }
        
        
        let queue = FMDatabaseQueue(path: path)
        
        queue?.inDatabase({ db in
            if let rs = try? db!.executeQuery(sql,values: nil) {
                while rs.next() {
                    let jsonData = rs.resultDictionary()
                }
                rs.close()
            }
        })
    }
    
    
   


    
}








