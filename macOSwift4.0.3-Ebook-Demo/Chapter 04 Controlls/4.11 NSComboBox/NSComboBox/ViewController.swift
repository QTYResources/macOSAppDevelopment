//
//  ViewController.swift
//  NSComboBox
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController,NSComboBoxDataSource,NSComboBoxDelegate {

    @IBOutlet weak var dynamicComboBox: NSComboBox!
    @IBOutlet weak var dataSourceComboBox: NSComboBox!
    
    var datas : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datas = ["Class1","Class2","Class3"]
        // Do any additional setup after loading the view.
       self.dynamicComboBoxConfig()
       self.dataSourceComboBoxConfig()
    }

    func dynamicComboBoxConfig(){
        let items = ["1","2","3"]
        //删除默认的初始数据
        self.dynamicComboBox.removeAllItems()
        //增加数据items
        self.dynamicComboBox.addItems(withObjectValues: items)
        //设置第一行数据为当前选中的数据
        self.dynamicComboBox.selectItem(at: 0)
    }
    
    func dataSourceComboBoxConfig(){
        self.dataSourceComboBox.usesDataSource = true
        self.dataSourceComboBox.dataSource = self
        self.dataSourceComboBox.delegate = self
    }

    // MARK: NSComboBoxDataSource
    
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return self.datas.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        return self.datas[index]
    }
    
    // MARK: NSComboBoxDelegate
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let comboBox = notification.object as! NSComboBox
        let selectedIndex = comboBox.indexOfSelectedItem
        let selectedContent = comboBox.stringValue
        
        print("selectedIndex = \(selectedIndex) selectedContent =\(selectedContent)")
    }
    
    // MARK: Action
    
    @IBAction func selectionChanged(_ sender: NSComboBox){
        
        let selectedIndex = sender.indexOfSelectedItem
        let selectedContent = sender.stringValue
        
        print("selectedIndex:\(selectedIndex) selectedContent:\(selectedContent)")
    }
    

}








