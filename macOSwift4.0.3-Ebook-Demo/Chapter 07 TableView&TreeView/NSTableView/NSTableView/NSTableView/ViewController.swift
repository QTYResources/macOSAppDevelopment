//
//  ViewController.swift
//  NSTableView
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    var datas = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableStyleConfig()
        self.updateData()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    func tableStyleConfig() {
        //表格网格线设置
        self.tableView.gridStyleMask = [NSTableView.GridLineStyle.dashedHorizontalGridLineMask,NSTableView.GridLineStyle.solidVerticalGridLineMask]
        //表格背景
        self.tableView.backgroundColor = NSColor.blue
        //背景颜色交替
        self.tableView.usesAlternatingRowBackgroundColors = true
        //表格行选中样式
        self.tableView.selectionHighlightStyle = .sourceList
    }

    func updateData() {
        self.datas = [
            ["name":"john","address":"USA","gender":"male","married":(1)],
            ["name":"mary","address":"China","gender":"female","married":(0)],
            ["name":"park","address":"Japan","gender":"male","married":(0)],
            ["name":"Daba","address":"Russia","gender":"female","married":(1)],
        ]
    }
    
    
    @IBAction func addTableRowButtonClicked(_ sender: NSButton) {
        
        let data = NSMutableDictionary()
        data["name"] = ""
        data["address"] = ""
        
        //增加数据到datas数据区
        self.datas.append(data)
        
        //刷新表数据
        self.tableView.reloadData()
        
        //定位光标到新添加的行
        self.tableView.editColumn(0, row: self.datas.count-1 , with: nil, select: true)
    }
    
    @IBAction func removeTableRowButtonClicked(_ sender: NSButton) {
        
        //表格当前选择的行
        let  row = self.tableView.selectedRow
        //如果row小于0表示没有选择行
        if row<0 {
            return
        }
        //从数据区删除选择的行的数据
        self.datas.remove(at: row)
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func removeTableMultiRowButtonClicked(_ sender: NSButton) {
        
        //表格当前选择的行
        let  rowIndexes = self.tableView.selectedRowIndexes
        //如果row小于0表示没有选择行
        if rowIndexes.count == 0  {
            return
        }
        
        self.tableView.beginUpdates()
        self.tableView.removeRows(at: rowIndexes, withAnimation: NSTableView.AnimationOptions.slideDown)
        self.tableView.endUpdates()
        
        let nsMutableArray = NSMutableArray(array: self.datas)
        nsMutableArray.removeObjects(at: rowIndexes)
        self.datas = nsMutableArray.copy() as! [NSDictionary]
    }
}


extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let data = self.datas[row]
        //表格列的标识
        let key = tableColumn?.identifier
        //单元格数据
        let value = data[key!]
        return value
    }
    
    
    func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
        
        let data = self.datas[row]
        //表格列的标识
        let key = tableColumn?.identifier
        
        let editData = NSMutableDictionary.init(dictionary: data)
        
        editData[key!] = object
        
        self.datas[row] = editData
        
    }
    
}





