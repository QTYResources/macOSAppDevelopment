//
//  DragImageDataItem.swift
//  DragDrop
//
//  Created by iDevFans on 16/7/25.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

final class DragImageDataItem: NSObject {
    var data: NSData?
}

extension DragImageDataItem: NSPasteboardReading {
    
    static func readableTypes(for pasteboard: NSPasteboard) -> [NSPasteboard.PasteboardType] {
        return [imagePboardType]
    }
    
    convenience init?(pasteboardPropertyList propertyList: Any, ofType type: NSPasteboard.PasteboardType) {
        self.init()
        data = propertyList as? NSData
    }
}
