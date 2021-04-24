//
//  CodeGenerate.swift
//  MDatabase
//
//  Created by iDevFans on 16/9/11.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class CodeGenerate: NSObject {

    func makeCode() {
        
        
        
        let tables = MDatabase.shared.tables() as [TableInfo]?
        if (tables?.count)! <= 0 {
            return
        }
        let engine = DMTemplateEngine.engine() as! DMTemplateEngine
        let template = self.loadModelTempalte(name: "Model.txt")
   
        for table  in tables! {
            let templateData = self.templateParametersWithTable(table: table)
            //从文件加载头文件模版
            engine.template = template
            //头文件源码渲染并写入文件
            let renderedHeadTemplate = engine.renderAgainst(templateData)
            print("renderedHeadTemplate\n \(renderedHeadTemplate) ")
            let headFileName = "\(table.name).swift"
            self.createFileWithName(fileName: headFileName, withFileConten: renderedHeadTemplate!)
        }
    }
    
    ///加载模版
    func loadModelTempalte(name: String) -> String? {
        let resourcePath = Bundle.main.resourcePath!
        let url =  URL(fileURLWithPath: resourcePath).appendingPathComponent(name).path
        let content = try? String(contentsOfFile: url)
        return  content
    }
    
    //／ 配置模版参数
    func templateParametersWithTable(table: Any) -> [String : Any] {
        var templateData = [String : Any]()
        //参数设置
        templateData["table"] = table
        templateData["Project"] = "Demo"
        templateData["Author"] = "MacDev"
        templateData["CreateDate"] = "2016-06-09"
        templateData["CopyRights"] = "www.macdev.io"
        return templateData
    }
    
    /// 创建文件
    func createFileWithName(fileName: String, withFileConten content: String) {
        let fm = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let fileOutPath = URL(fileURLWithPath: documentsDirectory).appendingPathComponent(fileName).path
        //创建输出文件
        fm.createFile(atPath: fileOutPath, contents: nil, attributes: nil)
        
        try? content.write(toFile: fileOutPath, atomically: true, encoding: String.Encoding.utf8)
    }
}
