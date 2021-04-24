//
//  ViewController.swift
//  NSTableViewCustomBackgroud
//
//  Created by iDevFans on 16/10/17.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var datas = [NSDictionary]()
    
    @IBOutlet weak var tableView: CustomTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        self.tableView.reloadData()
    }

    func updateData() {
        self.datas = [
            ["name":"john","address":"USA","gender":"male","married":(1)],
            ["name":"mary","address":"China","gender":"female","married":(0)],
            ["name":"park","address":"Japan","gender":"male","married":(0)],
            ["name":"Daba","address":"Russia","gender":"female","married":(1)],
        ]
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
}

extension ViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let data = self.datas[row]
        //表格列的标识
        let key = (tableColumn?.identifier)!
        //单元格数据
        let value = data[key]
        
        //根据表格列的标识,创建单元视图
        let view = tableView.make(withIdentifier: key, owner: self)
        let subviews = view?.subviews
        if (subviews?.count)!<=0 {
            return nil
        }
        
        if key == "name" || key == "address" {
            let textField = subviews?[0] as! NSTextField
            if value != nil {
                textField.stringValue = value as! String
            }
        }
        
        if key == "gender" {
            let comboField = subviews?[0] as! NSComboBox
            if value != nil {
                comboField.stringValue = value as! String
            }
        }
        
        if key == "married" {
            let checkBoxField = subviews?[0] as! NSButton
            checkBoxField.state = 0
            if (value != nil)  {
                checkBoxField.state = 1
            }
        }
        return view
    }
    
    func tableViewSelectionDidChange(_ notification: Notification){
        let tableView = notification.object as! NSTableView
        let row = tableView.selectedRow
        print("selection row \(row)")
    }
    
}






