//
//  DragSourceView.swift
//  DragDrop
//
//  Created by iDevFans on 16/7/25.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//




import Cocoa

public let kImagePboardTypeName = "macdev.io.imageDrag"
let imagePboardType = NSPasteboard.PasteboardType(rawValue: kImagePboardTypeName)

class DragSourceView: NSImageView {
    weak var dragSourceDelegate: NSDraggingSource?
    override func mouseDown(with event: NSEvent) {
        
        //拖放数据定义
        let pasteboardItem = NSPasteboardItem()
        //设置数据的Provider
        pasteboardItem.setDataProvider(self, forTypes: [ imagePboardType])
        
        //拖放item
        let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
        draggingItem.draggingFrame = NSRect(x: 0, y: 0, width: 16, height: 16)
        
        //拖放可视化图象设置
        draggingItem.imageComponentsProvider = {
        
            let component = NSDraggingImageComponent(key: NSDraggingItem.ImageComponentKey.icon)
        
            component.frame = NSRect(x: 0, y: 0, width: 16, height: 16)
            component.contents = NSImage(size: NSSize(width: 32,height: 32), flipped: false, drawingHandler: { [unowned self]  rect in {
                
                       self.image?.draw(in: rect)
                
                       return true
                }()
                
                }
            )
            return [component]
        }
        //开始启动拖放sesson
        self.beginDraggingSession(with: [draggingItem], event: event, source: self.dragSourceDelegate!)
    }
}


extension DragSourceView: NSPasteboardItemDataProvider {
    func pasteboard(_ pasteboard: NSPasteboard?, item: NSPasteboardItem, provideDataForType type: NSPasteboard.PasteboardType) {
        let data = self.image?.tiffRepresentation
        item.setData(data!, forType: type)
    }
}




