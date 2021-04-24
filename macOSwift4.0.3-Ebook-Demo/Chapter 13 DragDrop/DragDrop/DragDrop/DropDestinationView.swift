//
//  DropDestinationView.swift
//  DragDrop
//
//  Created by iDevFans on 16/7/25.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


class DropDestinationView: NSView {
    
    var imageItems: [DrawImageItem] = []
    override var isFlipped: Bool { return true }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        for i in 0 ..< self.imageItems.count {
            let drawImageItem:DrawImageItem = self.imageItems[i]
            let frame = NSRect(origin: drawImageItem.location!, size: CGSize(width: 16, height: 16))
            if let image = drawImageItem.image {
                image.draw(in: frame)
            }
        }
        
        // Drawing code here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wantsLayer = true
        self.layer?.borderColor = NSColor.red.cgColor
        self.layer?.borderWidth = 1
        //注册拖放的类型
        self.registerForDraggedTypes([imagePboardType])
    }
    
    
    //MARK: NSDraggingDestination
    
    //开始拖放，返回拖放类型
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return .generic
    }
    
    //退出拖放
    override func draggingExited(_ sender: NSDraggingInfo?) {
        
    }
    
    //拖放完成
    override func concludeDragOperation(_ sender: NSDraggingInfo?) {
        
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo?)-> Bool {
        
        return true
    }
   
    override func performDragOperation(_ sender: NSDraggingInfo?)-> Bool {
        
        let pboard = sender?.draggingPasteboard()
        //获取拖放数据
        let items = pboard?.readObjects(forClasses: [DragImageDataItem.self], options: nil)
        
        if (items?.count)! > 0 {
            
            let imageDataItem = items?[0] as! DragImageDataItem
            let img = NSImage(data: imageDataItem.data! as Data)
            
            //创建绘制的图像模型类
            let drawImageItem = DrawImageItem()
            drawImageItem.image = img
            let point = self.convert((sender?.draggingLocation())!, from: nil)
            drawImageItem.location = point
            
            //存储图象模型
            self.imageItems.append(drawImageItem)
            
            //触发视图重绘
            self.needsDisplay = true
        }
        return true
    }
}




