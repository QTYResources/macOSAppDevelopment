//
//  ViewController.swift
//  NSTableViewViewBased
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
   
    @IBOutlet var tableMenu: NSMenu!
    
    var datas = [NSDictionary]()
    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.updateData()
        // Do any additional setup after loading the view.
        
        self.tableView.doubleAction = #selector(ViewController.doubleAction(_:))
        
        tableView.selectionHighlightStyle = .regular
        
        
        self.tableView.menu = self.tableMenu
        
        self.tableView.menu?.delegate = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateData() {
        self.datas = [
            ["name":"john","address":"USA","gender":"male","married":(1)],
            ["name":"mary","address":"China","gender":"female","married":(0)],
            ["name":"park","address":"Japan","gender":"male","married":(0)],
            ["name":"Daba","address":"Russia","gender":"female","married":(1)],
        ]
    }
    
    
    @IBAction func doubleAction(_ sender: AnyObject ) {
        let row = self.tableView?.selectedRow
        print("double selection row \(row)")
    }
    
    
    func tableSortConfig() {
        for tableColumn in self.tableView.tableColumns {
            //升序排序
            let sortRules = NSSortDescriptor(key: tableColumn.identifier.rawValue, ascending: true)
            tableColumn.sortDescriptorPrototype = sortRules
        }
    }
    
    func tableSortConfig2() {
        for tableColumn in self.tableView.tableColumns {
            //升序排序 使用字符串标准的比较函数
            let sortRules = NSSortDescriptor(key: tableColumn.identifier.rawValue, ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
            
            tableColumn.sortDescriptorPrototype = sortRules
        }
    }
    
    func tableSortConfig3() {
        for tableColumn in self.tableView.tableColumns {
            //升序排序
            let sortRules = NSSortDescriptor(key: tableColumn.identifier.rawValue, ascending: true, comparator:{ s1,s2 in
                 let str1 = s1 as! String
                 let str2 = s2 as! String
                 if str1 > str2 {return .orderedAscending}
                 if str1 < str2 {return .orderedDescending}
                 return .orderedSame
                 }
            )
            
            tableColumn.sortDescriptorPrototype = sortRules
        }
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

    
}

//表格上下文菜单协议
extension ViewController: NSMenuDelegate {
    
    func menuNeedsUpdate(_ menu: NSMenu) {
        menu.removeAllItems()
        NSLog("menu clicked !")
    }
    
}



