//
//  ViewController.swift
//  CloudKitDemo
//
//  Created by iDevFans on 16/8/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
import CloudKit
class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.insertRecord()
    }

    func insertRecord() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        let recordID = CKRecordID(recordName: "1200")
        let record = CKRecord(recordType: "Home", recordID: recordID)
        record["name" ]   = "MacKerricher117" as CKRecordValue?
        record["address"] = "Mei Chen117" as CKRecordValue?
        database.save(record, completionHandler: {
            record,error in
            if error != nil {
                print("Save error\(error)")
            }
            
        })
    }
    
    
    func insertLocationRecord() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        let recordID = CKRecordID(recordName: "121")
        let record = CKRecord(recordType: "Home", recordID: recordID)
        record["name" ]   = "MacKerricher117" as CKRecordValue?
        record["address"] = "Mei Chen117" as CKRecordValue?
        
        let location = CLLocation(latitude: 23, longitude: 44)
        record["location"] = location
        
        database.save(record, completionHandler: {
            record,error in
            if error != nil {
                print("Save Location Record error\(error)")
            }
            
        })
    }
    
    func deleteRecord() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        let recordID = CKRecordID(recordName: "120")
        
        database.delete(withRecordID: recordID, completionHandler: {
            record,error in
                if error != nil {
                    print("error\(error)")
                }
            }
        )
    }
    
    
    func insertPictureRecord() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        let recordID = CKRecordID(recordName: "122")
        let record = CKRecord(recordType: "Home", recordID: recordID)
        record["name" ]   = "MacKerricher117" as CKRecordValue?
        record["address"] = "Mei Chen117" as CKRecordValue?
        
    
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        openDlg.begin(completionHandler: {  result in
            
            if(result.rawValue == NSFileHandlingPanelOKButton){
                let fileURLs = openDlg.urls
                //由于指定了只能选择一个文件因此只会循环一次
                for url:URL in fileURLs  {
                    let asset = CKAsset(fileURL: url)
                    record["picture"] = asset
                    database.save(record, completionHandler: {
                        record,error in
                        if error != nil {
                            print("Save Picture Record error\(error)")
                        }
                        
                    })
                }
            }
        })
    }
    
    
    func fetchRecordByID() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        let recordID = CKRecordID(recordName: "122")
        database.fetch(withRecordID: recordID,completionHandler: {
            record,error in
            if error != nil {
                print("fetchRecord error\(error)")
            }
        })
    }
    
    
    func fetchRecordByPredicate() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        
        let predicate = NSPredicate(format: "name = %@", "118")
        let query = CKQuery(recordType: "Home", predicate:predicate)
        
        database.perform(query, inZoneWith: nil, completionHandler: {
            records,error in
            if error != nil {
                print("fetchRecord error\(error)")
            }
        })
    }
    
    
    func createReference() {
        let myContainer = CKContainer.default()
        let database = myContainer.privateCloudDatabase
        
        let memberRecordID = CKRecordID(recordName: "122")
        let membersRecord = CKRecord(recordType: "Members", recordID: memberRecordID)
        membersRecord["name" ]   = "MacKerricher117" as CKRecordValue?
        membersRecord["address"] = "Mei Chen117" as CKRecordValue?
        
        
        let groupRecordID = CKRecordID(recordName: "Group222")
        let groupRecord = CKRecord(recordType: "Group", recordID: groupRecordID)
        groupRecord["groupID" ]   = 20 as CKRecordValue?
        groupRecord["name"] = "Group2" as CKRecordValue?
        
        //创建引用类型,action是操作类型,可以设置是否级联删除
        let groupReference = CKReference(record: groupRecord, action:.none)
        //建立group关联
        membersRecord["group"] = groupReference
        
        database.save(membersRecord, completionHandler: {
            record,error in
            if error != nil {
                print("Save Location Record error\(error)")
            }
        })
    }
    
    
    func fetchRecords() {
        
        let memberRecordID1 = CKRecordID(recordName: "1122")
        let memberRecordID2 = CKRecordID(recordName: "1133")
        let fetchRecordIDs = [memberRecordID1,memberRecordID2]
        
        //以fetchRecordIDs数组为参数构造多线程Operation
        let memberRecordsOperation = CKFetchRecordsOperation(recordIDs: fetchRecordIDs)
        //设置每返回一个查询结果的回调
        memberRecordsOperation.perRecordProgressBlock = { record,t in
               print("record \(record)")
        }
    
        //设置全部执行完成的block回调
        memberRecordsOperation.fetchRecordsCompletionBlock = {
        
            records,error in
            if error != nil {
                print("fetch record error \(error)")
            }
        }
    
        memberRecordsOperation.database = CKContainer.default().privateCloudDatabase
        //开始查询
        memberRecordsOperation.start()
        
    }

    

}











