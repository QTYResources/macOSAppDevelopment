//
//  HTTPClientSessionDelegate.swift
//  HTTPClient
//
//  Created by iDevFans on 16/9/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

typealias HTTPSessionDataTaskCompletionBlock =  ( _  response: URLResponse? ,  _  responseObject: Any?, _ error: Error?) -> ()

class HTTPClientSessionDelegate: NSObject, URLSessionDataDelegate {
    var taskCompletionHandler: HTTPSessionDataTaskCompletionBlock?
    var buffer: Data = Data()

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //缓存接收到的数据
        self.buffer.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let responseStr = String(data: self.buffer, encoding: String.Encoding.utf8)
        print("didReceive data =\(responseStr)")
        if let callback = taskCompletionHandler {
            callback(task.response,responseStr,error)
        }
        //释放 session 资源
        session.finishTasksAndInvalidate()
    }
}
