//
//  MDAO.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class MDAO: DAO {

    override func sqlQuery(sql: String) -> [AnyObject]? {
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db in
            let rs = try? db!.executeQuery(sql,values: nil)
            while rs!.next() {
                if let json = rs!.resultDictionary() {
                    let model = self.createModel(json: json as! [String:AnyObject])
                    modles.append(model)
                }
            }
            rs!.close()
        })
        return modles
    }
    
    
    override func sqlQuery(sql: String, withArgumentsIn args: [AnyObject]) -> [AnyObject]? {
        if args.count == 0 {
            return self.sqlQuery(sql: sql)
        }
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db in
            let rs = db!.executeQuery(sql, withArgumentsIn: args)
            while rs!.next() {
                if let json = rs!.resultDictionary() {
                    let model = self.createModel(json: json as! [String:AnyObject])
                    modles.append(model)
                }
            }
            rs!.close()
        })
        return modles
    }
    
    override func sqlQuery(sql: String, withParameterDictionary dics: [NSObject : AnyObject]) -> [AnyObject]? {
        let count = dics.keys.count
        if  count == 0 {
            return self.sqlQuery(sql:sql)
        }
        var modles = [AnyObject]()
        self.queue?.inDatabase({ db  in
            let rs =  db!.executeQuery(sql, withParameterDictionary: dics)
            while rs!.next() {
                if let json = rs!.resultDictionary() {
                    let model = self.createModel(json: json as! [String:AnyObject])
                    modles.append(model)
                }
            }
            rs!.close()
        })
        return modles
    }
    
    func createModel(json: [String:AnyObject])-> MModel {
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + self.tableName
        let aClass = NSClassFromString(className) as! MModel.Type
        let model = aClass.init()
        model.setValuesForKeys(json)
        return model
    }
}

