//
//  ViewController.swift
//  HTTP
//
//  Created by iDevFans on 16/9/27.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let   kServerBaseUrl = "http://127.0.0.1/iosxhelper/SAPI"

class ViewController: NSViewController {
    
    var buffer: Data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func urlSessionNoDelegateAction(_ sender: NSButton) {
        self.urlSessionNoDelegateTest()
    }
    
    
    @IBAction func urlSessionDelegateAction(_ sender: NSButton) {
        self.urlSessionDelegateTest()
    }
    
    @IBAction func uploadDataPostAction(_ sender: NSButton) {
        self.uploadDataPostTest()
    }
    
   
    func urlSessionNoDelegateTest() {
        
        let defaultConfigObject = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: kServerBaseUrl + "/VersionCheck")!
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let post = "versionNo=1.0&platform=Mac&channel=appstore&appName=DBAppX"
        let postData = post.data(using: String.Encoding.utf8)
        request.httpBody = postData
        
    
        let dataTask = session.dataTask(with: request,
                                                   completionHandler: {(data, response, error) -> Void in
            let responseStr = String(data: data!, encoding: String.Encoding.utf8)
            print("data =\(responseStr)")
                               
        })
        dataTask.resume()
    }

    
    func urlSessionDelegateTest(){
        //使用缺省对配置
        let defaultConfigObject = URLSessionConfiguration.default
        //创建 session 并设置它的代理
        let session = URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        
        let url = URL(string: kServerBaseUrl + "/VersionCheck")!
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let post = "versionNo=1.0&platform=Mac&channel=appstore&appName=DBAppX"
        let postData = post.data(using: String.Encoding.utf8)
        request.httpBody = postData
        
        let dataTask = session.dataTask(with: request)
        dataTask.resume()
    }
    
    
    func uploadDataPostTest() {
        
        //使用缺省对配置
        let defaultConfigObject = URLSessionConfiguration.default
        //创建 session 并设置它的代理
        let session = URLSession(configuration: defaultConfigObject, delegate: nil, delegateQueue: OperationQueue.main)
        
        let url = URL(string: kServerBaseUrl + "/VersionCheck")!
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let post = "versionNo=1.0&platform=Mac&channel=appstore&appName=DBAppX"
        let postData = post.data(using: String.Encoding.utf8)
       
        let uploadTask = session.uploadTask(with: request, from: postData, completionHandler: {(data, response, error) -> Void in
            let responseStr = String(data: data!, encoding: String.Encoding.utf8)
            print("uploadTask data =\(responseStr)")
            
        })
        uploadTask.resume()
    }
    

   
}



extension ViewController: URLSessionDataDelegate {
    
    //此代理方法为可选,用来控制请求,有4种参数可以设置(取消任务,继续进行,转为下载任务,转为流式任务)
    //不实现此代理方法时默认为允许继续进行任务。
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        completionHandler(.allow)
    }
  
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        //缓存接收到的数据
        self.buffer.append(data)
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        let responseStr = String(data: self.buffer, encoding: String.Encoding.utf8)
        print("didReceive data =\(responseStr)")
        //释放 session 资源
        session.finishTasksAndInvalidate()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Swift.Void) {
        
        var returnCachedResponse = proposedResponse
        var newUserInfo = [String: Any]()
        newUserInfo = [ "Cached Date" : Date() ]
        #if ALLOW_CACHING
            returnCachedResponse = CachedURLResponse(response: proposedResponse.response, data: proposedResponse.data, userInfo: newUserInfo, storagePolicy: proposedResponse.storagePolicy)
            completionHandler(returnCachedResponse)
        #else
            completionHandler(nil)
        #endif
        
    }
    
}



