//
//  ViewController.swift
//  HTTPClient
//
//  Created by iDevFans on 16/9/29.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let   kServerBaseUrl = "http://www.iosxhelper.com/SAPI"
//let   kServerBaseUrl = "http://127.0.0.1/iosxhelper/SAPI"

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func getAction(_ sender: AnyObject) {
        self.httpGetTest()
    }
    
    @IBAction func postAction(_ sender: AnyObject) {
        self.postStringTest()
    }
    
    @IBAction func postDictionaryAction(_ sender: AnyObject) {
        self.postDictionaryTest()
    }
    
    
    func httpGetTest(){
        let httpClient = HTTPClient()
        let urlString = "\(kServerBaseUrl)\("/VersionCheck")"
        let url = URL(string: urlString)
        
        httpClient.get(url!, parameters: nil, success: {(responseObject: Any?) -> Void in
            print("get data =\(responseObject!) ")
            }, failure: {(error: Error?) -> Void in
        })
    }
    
    
    func postStringTest(){
        let httpClient = HTTPClient()
        let urlString = "\(kServerBaseUrl)\("/VersionCheck")"
        let url = URL(string: urlString)
        let paras = "versionNo=1.0&platform=Mac&channel=appstore&appName=DBAppX"
        httpClient.post(url!, parameters: paras, success: {(responseObject: Any?) -> Void in
            print("post String responseObject =\(responseObject!) ")
            }, failure: {(error: Error?) -> Void in
        })
    }
    
    
    func postDictionaryTest(){
        let httpClient = HTTPClient()
        let urlString = "\(kServerBaseUrl)\("/VersionCheck")"
        
        let url = URL(string: urlString)
    
        let paras = ["versionNo": "1.0", "platform": "Mac", "channel": "appstore", "appName": "DBAppX"]

        httpClient.post(url!, parameters: paras, success: {(responseObject: Any?) -> Void in
            print("post Dictionary responseObject =\(responseObject!) ")
            }, failure: {(error: Error?) -> Void in
        })
    }

}


