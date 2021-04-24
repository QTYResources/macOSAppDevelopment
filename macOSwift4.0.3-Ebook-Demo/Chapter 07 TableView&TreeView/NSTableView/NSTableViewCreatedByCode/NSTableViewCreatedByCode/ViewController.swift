//
//  ViewController.swift
//  NSTableViewCreatedByCode
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    let tableView = NSTableView()
    let tableScrollView = NSScrollView()
    //存储表格数据的变量
    var datas = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //配置表格
        self.tableViewConfig()
        //配置滚动条视图
        self.tableScrollViewConfig()
        //设置滚动条自动布局
        self.autoLayoutConfig()
        //加载更新数据
        self.updateData()
    }

    func tableViewConfig() {
        
        self.tableView.focusRingType = .none
        //self.tableView.autoresizesSubviews = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "name"))
        column1.title = "name"
        column1.width = 80
        column1.maxWidth = 100
        column1.minWidth = 50
        self.tableView.addTableColumn(column1)
        
        let column2 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "address"))
        column2.title = "address"
        column2.width = 80
        column2.maxWidth = 100
        column2.minWidth = 50
        self.tableView.addTableColumn(column2)
    }
    
    func tableScrollViewConfig() {
        
        self.tableScrollView.hasVerticalScroller = false
        self.tableScrollView.hasVerticalScroller = false
        self.tableScrollView.focusRingType = .none
        self.tableScrollView.autohidesScrollers = true
        self.tableScrollView.borderType = .bezelBorder
        self.tableScrollView.translatesAutoresizingMaskIntoConstraints = false
    
        self.tableScrollView.documentView = self.tableView
        self.view.addSubview(self.tableScrollView)
    }
    
    
    func updateData() {
     
        self.datas = [
            ["name":"john","address":"USA"],
            ["name":"mary","address":"China"],
            ["name":"park","address":"Japan"],
            ["name":"Daba","address":"Russia"],
        ]
        
        self.tableView.reloadData()
    }
    

    func autoLayoutConfig() {
            
       let topAnchor = self.tableScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
       let bottomAnchor = self.tableScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        
       let leftAnchor =  self.tableScrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0)
       let rightAnchor = self.tableScrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
        
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leftAnchor, rightAnchor])
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
        var view = tableView.makeView(withIdentifier: key, owner: self)
       
        if view == nil {
        
            let cellView = NSTableCellView()
            cellView.identifier = identifier;
            view = cellView
            
            let textField =  NSTextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.isBezeled = false
            textField.drawsBackground = false

            cellView.addSubview(textField)
            
            let topAnchor = textField.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 0)
            let bottomAnchor = textField.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: 0)
            
            let leftAnchor =  textField.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 0)
            let rightAnchor = textField.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: 0)
            
            NSLayoutConstraint.activate([topAnchor,bottomAnchor,leftAnchor, rightAnchor])
            
        }
        
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
    
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
    
}

