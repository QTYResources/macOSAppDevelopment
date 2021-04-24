//
//  LocalizationFile.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class LocalizationFile {
    
    var name = ""
    var path = ""
    var isInfoPlistFile = false
    var languages = [LocalizationLang]()
    weak var project: XCProject?
    weak var group: XCGroup?
    
    convenience init(xCProject project: XCProject, group: XCGroup) {
        self.init()
        self.project = project
        self.group = group
    }
    
    func addLanguage(lang: LocalizationLang) {
        self.languages.append(lang)
    }
    
    func addNewLanguage(lang: LocalizationLang) {
        let fileName = (lang.path as NSString).lastPathComponent
        let relretivePath = "\(lang.name).lproj/\(fileName)"
        self.group?.addPlistFileReference(withPath: relretivePath, name: lang.name)
        self.project?.save()
        self.languages.append(lang)
    }
    
    func removeLanguage(lang: LocalizationLang) {
        self.languages.remove(at: self.languages.index(of: lang)!)
    }
    
    func removeLanguageAtIndex(index: Int) {
        self.languages.remove(at: index)
    }
    
    func baseLanguage() -> LocalizationLang? {

        for lang: LocalizationLang in self.languages {
            if (lang.name == "Base") {
                return lang
            }
        }
        
        for lang: LocalizationLang in self.languages {
            if (lang.name == "en") {
                return lang
            }
        }
        return nil
    }
    
}
