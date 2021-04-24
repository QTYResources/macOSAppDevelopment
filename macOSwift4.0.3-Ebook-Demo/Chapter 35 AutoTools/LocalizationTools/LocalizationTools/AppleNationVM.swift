//
//  AppleNationVM.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

//AppleNation View Model Class
class AppleNationVM: NSObject {
    var ID: Int = 0
    var code: String?
    var name: String?
    var chinaName: String?
    var selectedState:Int = 0 //是否选中,0表示没有选中
    
    convenience init(model:  AppleNation) {
        self.init()
        ID   = model.ID
        code = model.code
        name = model.name
        chinaName = model.chinaName
    }
    
    
    
}
