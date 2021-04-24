//
//  ViewController.swift
//  DragDrop
//
//  Created by iDevFans on 16/7/24.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    @IBOutlet weak var sourceView: DragSourceView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sourceView.dragSourceDelegate = self
    }
}

extension ViewController: NSDraggingSource {
    
    //返回拖放操作类型
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .generic
    }
    
    //开始拖放代理回调
    func draggingSession(_ session: NSDraggingSession, willBeginAt screenPoint: NSPoint) {
        print("draggingSession beginAt \(screenPoint)")
    }
    
    //拖放鼠标移动时的代理回调
    func draggingSession(_ session: NSDraggingSession, movedTo screenPoint: NSPoint) {
        print("draggingSession movedTo \(screenPoint)")
    }
    
    //结束拖放代理回调
    func draggingSession(_ session: NSDraggingSession, endedAt screenPoint: NSPoint, operation: NSDragOperation) {
        print("draggingSession endedAt \(screenPoint)")
    }
}


