//
//  LocalizationProject.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kKeyStringsFile = "Localizable.strings"
let kInfoPlistFile  = "InfoPlist.strings"

class LocalizationProject: NSObject {
    var prjName = ""
    var prjPath = ""
    var files = [LocalizationFile]()
    var project: XCProject?
    var localizableGroup: XCGroup?
    var infoPlistGroup: XCGroup?
    
    convenience init(path: String) {
        self.init()
        prjPath = path
        prjName = (prjPath as NSString).lastPathComponent
        project = XCProject.init(filePath: prjPath)
    }
    
    func localizationParse() {
        let files = self.project?.files().filter({
            return NSSet(object: kKeyStringsFile).contains(URL(fileURLWithPath: $0.name).lastPathComponent)
        })
    
        
        var localizableLoc: LocalizationFile?
        for file: XCSourceFile in files! {
            //var fullpath = file.pathRelativeToProjectRoot()
            let group = self.project?.groupForGroupMember(withKey: file.key)
            //let parentGroup = self.project?.groupForGroupMember(withKey: file.key).parent
            
            let language = file.name.deletingLastPathComponent().lastPathComponent().deletingPathExtension()

            
            let filePath = project?.filePath()!.deletingLastPathComponent().appendingPathComponent(path: file.pathRelativeToProjectRoot())
          
            let fileName = file.name.lastPathComponent()
            
            if (fileName == kKeyStringsFile) {
                if localizableLoc == nil {
                    localizableLoc = LocalizationFile(xCProject: self.project!, group: group!)
                    localizableLoc?.name = fileName
                    localizableLoc?.path = filePath!.deletingLastPathComponent().deletingLastPathComponent()
                    self.files.append(localizableLoc!)
                    self.localizableGroup = group
                }
                let lang  = LocalizationLang()
                lang.name = language
                lang.path = filePath!
                lang.file = localizableLoc
                localizableLoc?.addLanguage(lang: lang)
            }
        }
        self.project?.save()
    }
    
    func localizationFiles() -> [LocalizationFile] {
        return self.files
    }
}
