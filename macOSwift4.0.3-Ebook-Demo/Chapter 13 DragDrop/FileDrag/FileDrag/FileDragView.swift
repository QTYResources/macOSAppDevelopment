//
//  FileDragView.swift
//  FileDrag
//
//  Created by iDevFans on 16/7/26.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

//文件拖放应用代理协议
protocol FileDragDelegate: class {
    func didFinishDrag(_ filePath:String)
}

class FileDragView: NSView {

    weak var delegate: FileDragDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //注册文件拖放类型
        self.registerForDraggedTypes([NSFilenamesPboardType])
    }
    
    //MARK: NSDraggingDestination
    
    //开始拖放，返回拖放类型
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let sourceDragMask = sender.draggingSourceOperationMask()
        let pboard = sender.draggingPasteboard()
        let dragTypes = pboard.types! as NSArray
        if dragTypes.contains(NSFilenamesPboardType) {
            if sourceDragMask.contains([.link]) {
                return .link
            }
            if sourceDragMask.contains([.copy]) {
                return .copy
            }
        }
        return .generic
    }
    
    //拖放文件进入拖放区，返回拖放操作类型
    override func performDragOperation(_ sender: NSDraggingInfo?)-> Bool {
        let pboard = sender?.draggingPasteboard()
        let dragTypes = pboard!.types! as NSArray
        if dragTypes.contains(NSFilenamesPboardType) {
            let files = (pboard?.propertyList(forType: NSFilenamesPboardType))! as!  Array<String>
            let numberOfFiles = files.count
            if numberOfFiles > 0 {
                let filePath = files[0] as String
                //代理通知
                if let delegate = self.delegate {
                    NSLog("filePath \(filePath)")
                    delegate.didFinishDrag(filePath)
                }
            }
        }
        return true
    }
}

