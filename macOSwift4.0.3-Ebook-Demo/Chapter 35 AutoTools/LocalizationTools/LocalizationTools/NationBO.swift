//
//  NationBO.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/8/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NationBO: NSObject {

    private static let  sharedInstance = NationBO()
    class var shared: NationBO {
        return sharedInstance
    }
    
    //nation code -> nation name
    private lazy var appleNationMap: [String : String] = {
        var map = [String : String]()
        if let nations  = self.appleNations {
            for nation: AppleNation in nations {
                if let name = nation.name , let code = nation.code {
                    map[code] = name
                }
            }
        }
        return map
    }()
    
    private lazy var appleNationDAO: AppleNationDAO = {
        let dao = AppleNationDAO()
        return dao
    }()
    
    private lazy var googleNationDAO: NationDAO = {
        let dao = NationDAO()
        return dao
    }()
    
    func nationName(fromCode code:String) -> String? {
        return appleNationMap[code]
    }
    
    lazy var appleNations: [AppleNation]? = {
        let appleNations = self.appleNationDAO.sqlQuery(sql: "select * from AppleNation order by code asc") as? [AppleNation]
       
        return appleNations
    }()
    
    lazy var googleNations: [Nation]? = {
        let googleNations = self.googleNationDAO.sqlQuery(sql: "select * from Nation order by code asc") as? [Nation]
        return googleNations
    }()
    
    
    lazy var appleNationsVM: [AppleNationVM]? = {
        let appleNations = self.appleNations
        var vms = [AppleNationVM]()
        for appleNation in appleNations! {
            let vm = AppleNationVM(model: appleNation)
            vms.append(vm)
        }
        return vms
    }()
}
