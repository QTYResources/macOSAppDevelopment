//
//  FileManager+Ext.swift
//  ImageAassetAutomator
//
//  Created by iDevFans on 16/8/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation

extension FileManager {
    
    func createPathIfNeded(path: String) ->Bool {
        let success = self.fileExists(atPath: path)
        if !success {
            try? self.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    
        return true
    }
    
    func createFileIfNeeded(filePath: String) ->Bool {
        
        var success = self.fileExists(atPath: filePath)
        if !success {
            success = self.createFile(atPath: filePath, contents: nil, attributes: nil)
        }
        
        return success
    }
    
    func readFilesAtPath(path: String) ->[String]? {
        let success = self.fileExists(atPath: path)
        if !success {
            return nil
        }
        let files = try? self.contentsOfDirectory(atPath: path)
        
        return files
    }
    
    func clearAllFilesAtPath(path: String) {
        
        let files = self.readFilesAtPath(path: path)
        for fileName in files! {
            let filePath = "\(path)/\(fileName)"
            try? self.removeItem(atPath: filePath)
        }
    }
}





