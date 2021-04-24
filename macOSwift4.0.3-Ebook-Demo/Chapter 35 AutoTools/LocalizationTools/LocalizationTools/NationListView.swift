//
//  NationListView.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/2.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

//文件拖放代理协议
protocol FileDragDelegate: class {
    func didFinishDrag(_ filePath:String)
}

class NationListView: NSTableView {
    
    override var isFlipped: Bool {
        return true
    }
    
    weak var dragDelegate: FileDragDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册文件拖放类型
        self.registerForDraggedTypes([NSPasteboard.PasteboardType.backwardsCompatibleFileURL])
    }
    
    //MARK: NSDraggingDestination
    
    //开始拖放，返回拖放类型
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let sourceDragMask = sender.draggingSourceOperationMask()
        let pboard = sender.draggingPasteboard()
        let dragTypes = pboard.types! as NSArray
        if dragTypes.contains(NSPasteboard.PasteboardType.backwardsCompatibleFileURL) {
            if sourceDragMask.contains([.link]) {
                NSLog("draggingExited link")
                return .link
            }
            if sourceDragMask.contains([.copy]) {
                return .copy
            }
        }
        return .generic
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation{
        return self.draggingEntered(sender)
    }
    
    //拖放文件进入拖放区，返回拖放操作类型
    override func performDragOperation(_ sender: NSDraggingInfo?)-> Bool {
        guard let pboard = sender?.draggingPasteboard() else {
            return false
        }
        let fileURLType = NSPasteboard.PasteboardType.backwardsCompatibleFileURL
        if (pboard.types?.contains(fileURLType))! {
            var filePath: String?
            if #available(OSX 10.13, *) {
                if let utTypeFilePath = pboard.propertyList(forType:fileURLType) as? URL {
                    filePath = utTypeFilePath.path
                }
            }
            else {
                // UTType 类型的文件路径，需要转换成标准路径
                if let utTypeFilePath = pboard.string(forType:fileURLType) {
                    filePath =  URL(fileURLWithPath: utTypeFilePath).standardized.path
                }
            }
            //代理通知
            if let delegate = self.dragDelegate , let filePath = filePath {
                NSLog("filePath \(filePath)")
                delegate.didFinishDrag(filePath)
            }
        }
        return true
    }
}




