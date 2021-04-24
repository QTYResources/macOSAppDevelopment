//
//  ViewController.swift
//  CustomTableView
//
//  Created by iDevFans on 16/10/17.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var datas = [NSDictionary]()
    
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = NSTableHeaderView(frame: NSMakeRect(0, 0, 120, 30))
        //self.tableView.headerView = headerView
        
        //self.tableView.usesAlternatingRowBackgroundColors = true
         tableView.gridColor = NSColor.purple
        self.updateData()
        self.tableView.reloadData()
        
       
        
        //self.tableView.selectionHighlightStyle = .none
      
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
        
        if key.rawValue == "gender" {
            let comboField = subviews?[0] as! NSComboBox
            if value != nil {
                comboField.stringValue = value as! String
            }
        }
        
        if key.rawValue == "married" {
            let checkBoxField = subviews?[0] as! NSButton
            checkBoxField.state = NSControl.StateValue(rawValue: 0)
            if (value != nil)  {
                checkBoxField.state = NSControl.StateValue(rawValue: 1)
            }
        }
        return view
    }
    
    func tableViewSelectionDidChange(_ notification: Notification){
        let tableView = notification.object as! NSTableView
        let row = tableView.selectedRow
        print("selection row \(row)")
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        guard let rowView = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier(rawValue: "RowView"), owner: nil) as! CustomTableRowView? else {
            let rowView = CustomTableRowView()
            rowView.identifier = NSUserInterfaceItemIdentifier(rawValue: "RowView")
            return rowView
        }
        return rowView
    }
    
    
//    func tableView(_ tableView: NSTableView, isGroupRow row: Int) -> Bool {
//        
//        if row  % 2 == 1 {
//             return true
//        }
//        return false
//    }
//
    
   
}







