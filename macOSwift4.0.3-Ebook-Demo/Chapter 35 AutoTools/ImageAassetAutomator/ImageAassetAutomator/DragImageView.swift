//
//  DragImageView.swift
//  ImageAassetAutomator
//
//  Created by iDevFans on 16/8/23.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa


public protocol DragImageZoneDelegate: class {
    func didFinishDragWithFile(_ filePath:String)
}

class DragImageView: NSImageView {
    weak var delegate: DragImageZoneDelegate?
   
    func dropAreaFadeIn() {
        self.alphaValue = 1.0
    }
    
    func dropAreaFadeOut() {
        self.alphaValue = 0.2
    }
}

extension DragImageView  {
    // 实现 NSDraggingDestination 代理协议接口
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let sourceDragMask = sender.draggingSourceOperationMask()
        let pboard = sender.draggingPasteboard()
        let fileURLType = NSPasteboard.PasteboardType.backwardsCompatibleFileURL
        if (pboard.types?.contains(fileURLType))! {
            if sourceDragMask == .copy {
                return .copy
            }
            if sourceDragMask == .link {
                return .link
            }
        }
        return .every
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.dropAreaFadeOut()
    }
    
    //拖放完成后 执行 DragImageZoneDelegate 代理协议回调
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let pboard = sender.draggingPasteboard()
        self.dropAreaFadeOut()
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
           
            if let dragDelegate = delegate , let filePath = filePath {
                dragDelegate.didFinishDragWithFile(filePath)
            }
        }
        return true
    }
}
