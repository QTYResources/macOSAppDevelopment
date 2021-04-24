//
//  ViewController.swift
//  DataTransformer
//
//  Created by iDevFans on 16/8/12.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    lazy var dateField: DataField = {
        let dataField = DataField()
        dataField.name = "john"
        dataField.type = (Int)(DBDataType.dateDataType.rawValue)
        return dataField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func selectionChaned(_ sender: NSComboBox){
        
        let type = sender.indexOfSelectedItem
        print("dateField.type = \(dateField.type)")
        print("selectionChaned type indexOfSelectedItem \(type), \(sender.stringValue)")
    }


}


