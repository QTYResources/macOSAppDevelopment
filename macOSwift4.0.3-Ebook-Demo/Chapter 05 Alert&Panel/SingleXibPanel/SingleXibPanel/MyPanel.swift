//
//  MyPanel.swift
//  SingleXibPanel
//
//  Created by iDevFans on 16/10/18.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class MyPanel: NSPanel {

    var datas = [NSDictionary]()
    
    @IBOutlet weak var tableView: NSTableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.updateData()
    }
    
    func updateData() {
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
    }
    
    @IBAction func okAction(_ sender: AnyObject?) {
        self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(rawValue: kOkCode))
    }
    
    @IBAction func cancelAction(_ sender: AnyObject?) {
        self.parent?.endSheet(self, returnCode: NSApplication.ModalResponse(rawValue: kCancelCode))
    }
}

extension MyPanel: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
}

extension MyPanel: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let data = self.datas[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
        //单元格数据
        let value = data[key]
        
        //根据表格列的标识,创建单元视图
        let view = tableView.makeView(withIdentifier: key, owner: self)
        let subviews = view?.subviews
        if (subviews?.count)!<=0 {
            return nil
        }
        
        if key.rawValue == "name" || key.rawValue == "address" {
            let textField = subviews?[0] as! NSTextField
            if value != nil {
                textField.stringValue = value as! String
            }
        }
        
        return view
    }
    
    
}


