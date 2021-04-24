//
//  ServiceProvider.swift
//  SysServiceDemo
//
//  Created by iDevFans on 16/7/31.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ServiceProvider: NSObject  {
    
    func upperCaseText(_ pboard: NSPasteboard!,
                         userData: String!,
                         error: AutoreleasingUnsafeMutablePointer<String>) {
        
        
        if (pboard.types?.contains(NSPasteboard.PasteboardType.string) == nil) {
            error.pointee = NSLocalizedString("Error: couldn't convert text.", comment: "pboard couldn't uppercase string.")
            return
        }
        
        let pboardString = pboard.string(forType:NSPasteboard.PasteboardType.string)
        let uppserCaseString = self.convertToUpperCase(pboardString!)
        guard uppserCaseString != nil else {
            //错误返回信息
            error.pointee = NSLocalizedString("Error: couldn't convert text.", comment: "pboard couldn't uppercase string.")
            
            return
        }
        pboard.clearContents()
        pboard.writeObjects([uppserCaseString! as NSPasteboardWriting])
    }
    
    
    //字符小写转换大写的测试函数
    func convertToUpperCase(_ string: String) ->String? {
        if string.characters.count > 0 {
            return string.uppercased()
        }
        return nil
    }
}
