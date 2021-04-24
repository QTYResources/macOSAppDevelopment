//
//  LocalizationLang.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class LocalizationLang: NSObject {
    var name = ""
    var path = ""
    var keySourceTargetSet = [String]()
    weak var file: LocalizationFile?

    func fileContent() -> String? {
        let string = try? String(contentsOfFile: self.path)
        return string
    }
    
}
