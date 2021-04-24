//
//  ViewController.swift
//  HTTPFileDownUpload
//
//  Created by iDevFans on 16/9/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa



class ViewController: NSViewController {

    var downTask: URLSessionDownloadTask?
    var resumeData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlCache = URLCache(memoryCapacity: 2 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
        URLCache.shared = urlCache
    }

    
    
    @IBAction func urlSessionDownloadFileAction(_ sender: NSButton) {
        self.urlSessionDownloadFileTest()
    }
    
    
    @IBAction func urlSessionUploadFileAction(_ sender: NSButton) {
        self.urlSessionUploadFileTest()
    }
    
    
    @IBAction func urlSessionUploadFormFileAction(_ sender: NSButton) {
        self.urlSessionUploadFormFileTest()
    }
    

    @IBAction func startDown(_ sender: NSButton) {
        let defaultConfigObject = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: "http://devstreaming.apple.com/videos/wwdc/2015/1026npwuy2crj2xyuq11/102/102_platforms_state_of_the_union.pdf?dl=1")!
        let task = session.downloadTask(with: url)
        self.downTask = task
        task.resume()
    }
    
    @IBAction func stopDown(_ sender: NSButton) {
        self.downTask?.cancel(byProducingResumeData: { data in
            self.resumeData = data
        })
    }
    
    @IBAction func resumeDown(_ sender: NSButton) {
        let defaultConfigObject = URLSessionConfiguration.default
        let session = URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        self.downTask = session.downloadTask(withResumeData: self.resumeData!)
        self.downTask?.resume()
    }
    
    func urlSessionDownloadFileTest() {
        
        let defaultConfigObject = URLSessionConfiguration.default
        //创建session 指定代理和任务队列
        let session = URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        //指定需要下载的文件URL路径
        let url = URL(string: "https://raw.githubusercontent.com/javaliker/SwiftSQLiteApp/master/Browse.png")!
        //创建Download任务
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    func urlSessionUploadFileTest() {
        
        let uploadURL = URL(string: "http://127.0.0.1/fileUpload.php")!
        // Create the Request
        var request = URLRequest(url: uploadURL)
        request.httpMethod = "POST"
        //要上传的路径，假设 Documents 目录下面有个 AppBkIcon.png 文件
        let uploadfileURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents").appendingPathComponent("AppBkIcon.png")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        let defaultConfigObject = URLSessionConfiguration.default
        
        let session = URLSession(configuration: defaultConfigObject, delegate: self, delegateQueue: OperationQueue.main)
        
        let uploadTask = session.uploadTask(with: request, fromFile: uploadfileURL, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print("error =\(error)")

            }
    
            
        })
        uploadTask.resume()
        
        
    }
    
    
    func urlSessionUploadFormFileTest(){
        
        //服务端上传的 url
        let urlString = "http://127.0.0.1/formUpload.php"
        let url = URL(string: urlString)!
        //上传的文件路径
        let fileURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents").appendingPathComponent("AppBkIcon.png")
       
        let fileName = fileURL.lastPathComponent
        
        let fileData = try? Data(contentsOf: fileURL)
        
        let boundary = "-boundary"
       
        // 上传的数据缓存
        var dataSend = Data()
        
        // boundary 参数填充 开始
        dataSend.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        // form表单的参数
        dataSend.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using:String.Encoding.utf8 )!)
        
        dataSend.append("Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8)!)
        dataSend.append(fileData!)
        dataSend.append("\r\n".data(using: String.Encoding.utf8)!)
        
        // boundary 参数填充 结束
        dataSend.append("--\(boundary)--\r\n\r\n".data(using: String.Encoding.utf8)!)

        //请求参数
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = dataSend
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        // 发起上传任务
        let sessionUploadTask = session.uploadTask(with: request, from: dataSend)
        sessionUploadTask.resume()

    }
    
    

}



extension ViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //获取原始的文件名
        let fileName = downloadTask.originalRequest?.url?.lastPathComponent

        let fileManager = FileManager.default

        //要保存的路径
        let downloadURL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Downloads").appendingPathComponent(fileName!)
        //从下载的临时路径移动到期望的路径
        do {
            try fileManager.moveItem(at: location, to: downloadURL)
        }
        catch let error {
            print("error \(error)")
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("receive bytes \(bytesWritten) of totalBytes \(totalBytesExpectedToWrite)")
    }


    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
         print("resumeAtOffset  bytes \(fileOffset) of totalBytes \(expectedTotalBytes)")
    }
    
    
    
    
}



extension ViewController: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
         print("Send bytes \(bytesSent) of totalBytes \(totalBytesExpectedToSend)")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil {
            let sessionError = error as! NSError
            if let userInfo = sessionError.userInfo[NSURLSessionDownloadTaskResumeData] {
                print("userInfo \(userInfo)")

            }
            print("error \(error)")
        }
    }

}


