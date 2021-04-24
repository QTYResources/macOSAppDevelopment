//
//  HTTPImageOperation.swift
//  OperationQueue
//
//  Created by iDevFans on 16/9/30.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

//下载完成回调接口
typealias DownCompletionBlock =  ( _ image: NSImage?) -> ()

class HTTPImageOperation: Operation {
    
    var url: URL!
    var downCompletionBlock: DownCompletionBlock?
    
    var _executing = false
    var _finished = false
    
    convenience init(imageURL url: URL?) {
        self.init()
        self.url = url!
    }

    //表示是否允许并发执行
    override var isAsynchronous: Bool {
        return true
    }
   
    override var isExecuting: Bool {
        return _executing
    }
    
    override var isFinished: Bool {
        return _finished
    }
    
    override func start() {
        if self.isCancelled {
            self.willChangeValue(forKey: "isFinished")
            _finished = true
            self.didChangeValue(forKey: "isFinished")
            return
        }
        self.willChangeValue(forKey: "isExecuting")
        
        Thread.detachNewThreadSelector(#selector(self.main), toTarget: self, with: nil)
       
        _executing = true
        self.didChangeValue(forKey: "isExecuting")
    }
    
    override func main() {
        let image = NSImage(contentsOf: self.url)
        if let callback = self.downCompletionBlock {
            callback(image)
        }
        self.complete()
    }
    
    func complete() {
        self.willChangeValue(forKey: "isFinished")
        self.willChangeValue(forKey: "isExecuting")
        _executing = false
        _finished = true
        self.didChangeValue(forKey: "isExecuting")
        self.didChangeValue(forKey: "isFinished")
    }
}
