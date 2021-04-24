//
//  ViewController.swift
//  NSTableViewDragDrop
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

let kTableViewDragDataTypeName = "TableViewDragDataTypeName"
class ViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    var datas = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        self.tableView.register(forDraggedTypes: [kTableViewDragDataTypeName])

    }

    func updateData() {
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
    }
}


extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: NSTableView, writeRowsWith rowIndexes: IndexSet, to pboard: NSPasteboard) -> Bool {

        let zNSIndexSetData = NSKeyedArchiver.archivedData(withRootObject: rowIndexes);
        pboard.declareTypes([kTableViewDragDataTypeName], owner: self)
        pboard.setData(zNSIndexSetData, forType: kTableViewDragDataTypeName)
        return true
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableViewDropOperation) -> NSDragOperation {
        return .every
    }
    
    func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableViewDropOperation) -> Bool {
    
        let pboard = info.draggingPasteboard()
        let rowData = pboard.data(forType: kTableViewDragDataTypeName)
        let rowIndexes = NSKeyedUnarchiver.unarchiveObject(with: rowData!) as! NSIndexSet
        let dragRow = rowIndexes.firstIndex
        
        let temp = self.datas[row]
        self.datas[row] = self.datas[dragRow]
        self.datas[dragRow] = temp
        
        tableView.reloadData()
        return true
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
        
        let textField = subviews?[0] as! NSTextField
        if value != nil {
            textField.stringValue = value as! String
        }
        
        return view
    }
}


