//
//  NSTableColumn+ColumnItem.swift
//  TableViewControllerDemo
//
//  Created by iDevFans on 16/8/20.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import Cocoa

extension NSTableColumn {
    
    static func column(_ item: TableColumnItem) -> NSTableColumn{
        let column = NSTableColumn()
        if let identifier = item.identifier {
            column.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier)
        }
        column.width      = item.width
        column.minWidth   = item.minWidth
        column.maxWidth   = item.maxWidth
        column.isEditable = item.editable
        column.updateHeaderCellWithItem(item)
        return column
    }
    
    func updateHeaderCellWithItem(_ item: TableColumnItem) {
        if let headTitle = item.title {
            self.headerCell.title = headTitle
        }
        self.headerCell.alignment = item.headerAlignment
        self.headerCell.lineBreakMode = .byTruncatingMiddle
    }
}
