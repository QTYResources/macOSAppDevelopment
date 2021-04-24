//
//  MyTableView.swift
//  NSTableViewViewBased
//
//  Created by iDevFans on 16/7/10.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class MyTableView: NSTableView {
    var menu1: NSMenu?
    var menu2: NSMenu?
    override func menu(for event: NSEvent) -> NSMenu? {
        let row = self.selectedRow
        let col = self.selectedColumn
        if (row == 0 && col == 1) {
            return self.menu1
        }
        return  self.menu2
    }
}
