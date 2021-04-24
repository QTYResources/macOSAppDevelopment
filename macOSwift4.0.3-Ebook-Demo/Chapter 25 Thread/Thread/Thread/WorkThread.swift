//
//  WorkThread.swift
//  Thread
//
//  Created by iDevFans on 16/10/1.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

protocol ImageDownloadDelegate: class {
    func didFinishDown(_ image: NSImage?)
}

class WorkThread: Thread {
    
    var url: URL!
    weak var delegate: ImageDownloadDelegate?
    
    convenience init(imageURL url: URL?) {
        self.init()
        self.url = url!
    }
    
    override func main() {
        print("start main")
        autoreleasepool {
            let image = NSImage(contentsOf: url)
            if let downloadDelegate = delegate {
                downloadDelegate.didFinishDown(image)
                print("end main")
            }
        }
    }
}
