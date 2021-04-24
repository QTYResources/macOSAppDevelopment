//
//  ViewController.swift
//  NSPopUpButton
//
//  Created by iDevFans on 16/6/29.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var popUpButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dynamicDataConfig()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    func dynamicDataConfig(){
        let items = ["1","2","3"]
        //删除默认的初始数据
        self.popUpButton.removeAllItems()
        //增加数据items
        self.popUpButton.addItems(withTitles: items)
        //设置第一行数据为当前选中的数据
        self.popUpButton.selectItem(at: 0)
    }
    
    @IBAction func popUpBtnAction(_ sender: NSPopUpButton){
        let items = sender.itemTitles
        //当前选择的index
        let index = sender.indexOfSelectedItem
        //选择的文本内容
        let title =  items[index]
        print("select title \(title)")
    }

}





