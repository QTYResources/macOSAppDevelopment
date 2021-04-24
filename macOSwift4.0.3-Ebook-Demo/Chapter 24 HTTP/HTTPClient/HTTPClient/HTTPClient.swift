//
//  HTTPClient.swift
//  HTTPClient
//
//  Created by iDevFans on 16/9/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class HTTPClient: NSObject {
   
    var sessionConfiguration = URLSessionConfiguration.default
    
    lazy var operationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 1
        return operationQueue
    }()
    
    lazy var session: URLSession = {
      return  URLSession(configuration: self.sessionConfiguration, delegate: self, delegateQueue: self.operationQueue)
    }()
   
    //代理缓存
    var taskDelegates =  [AnyHashable: HTTPClientSessionDelegate?]()
    
    //资源保护锁
    var lock = NSLock()

    func get(_ url: URL, parameters: Any?, success: @escaping (_ responseData: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var request: URLRequest
        let postStr = self.formatParas(paras: parameters)
        if let paras = postStr {
            let baseURLString = url.path + "?" + paras
            request = URLRequest(url: URL(string: baseURLString)!)
        }
        else {
            request = URLRequest(url: url)
        }
        let task = self.dataTask(with: request, success: success, failure: failure)
        task.resume()
    }
    
    func post(_ url: URL, parameters: Any?, success: @escaping (_ responseData: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let postStr = self.formatParas(paras: parameters)
        if let str = postStr {
            let postData = str.data(using: String.Encoding.utf8)!
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
            request.httpBody = postData
        }
        
        let  task = self.dataTask(with: request, success: success, failure: failure)
        task.resume()
    }
    
    //参数格式化
    func formatParas(paras parameters: Any) -> String? {
        var postStr: String?
        if (parameters is String) {
            postStr = parameters as? String
        }
        if (parameters is [AnyHashable: Any]) {
            let keyValues = parameters as! [AnyHashable: Any]
            var tempStr = String()
            var index = 0
            for (key, obj) in keyValues {
                if index > 0 {
                    tempStr += "&"
                }
                let kv = "\(key)=\(obj)"
                tempStr += kv
                index += 1
            }
            postStr = tempStr
        }
        return postStr
    }
    
    //创建任务
    func dataTask(with request: URLRequest, success: @escaping (_ responseData: Any?) -> Void, failure: @escaping (_ error: Error?) -> Void) -> URLSessionDataTask {
        let dataTask = self.session.dataTask(with: request)
        let completionHandler = {(response: URLResponse?, responseObject: Any?, error: Error?) -> Void in
            if error != nil {
                failure(error)
            }
            else {
                success(responseObject)
            }
        }
        self.add(completionHandler, for: dataTask)
        return dataTask
    }
    
    func add(_ completionHandler: @escaping HTTPSessionDataTaskCompletionBlock, for task: URLSessionDataTask) {
        let sessionDelegate = HTTPClientSessionDelegate()
        sessionDelegate.taskCompletionHandler = completionHandler
        self.lock.lock()
        self.taskDelegates[(task.taskIdentifier)] = sessionDelegate
        self.lock.unlock()
    }
}

//代理协议
extension HTTPClient: URLSessionDataDelegate {
    
    //数据接收
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let  sessionDelegate = self.taskDelegates[(dataTask.taskIdentifier)]
        if let delegate = sessionDelegate {
            delegate?.urlSession(session, dataTask: dataTask, didReceive: data)
        }
    }
    
    //请求完成
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let  sessionDelegate = self.taskDelegates[(task.taskIdentifier)]
        if let delegate = sessionDelegate {
            delegate?.urlSession(session, task: task, didCompleteWithError: error)
        }
    }
}



