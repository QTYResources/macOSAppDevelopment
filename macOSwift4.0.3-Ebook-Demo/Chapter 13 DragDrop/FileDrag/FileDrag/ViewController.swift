//
//  ViewController.swift
//  FileDrag
//
//  Created by iDevFans on 16/7/26.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    @IBOutlet var dragView: FileDragView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置代理
        self.dragView.delegate = self
    }
}

//实现代理方法
extension ViewController: FileDragDelegate {
    func didFinishDrag(_ filePath:String) {
        let url = NSURL(fileURLWithPath: filePath)
        guard let string = try?  NSString.init(contentsOf: url as URL, encoding: String.Encoding.utf8.rawValue)
            else {
                return
        }
        self.textView.string = string as String
    }
}
