//
//  ViewController.swift
//  FileWrapper
//
//  Created by iDevFans on 16/8/5.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var imageView: NSImageView!
    
     @IBOutlet weak var textField: NSTextField!
    
    @objc dynamic var image: NSImage?
    @objc dynamic var text: String?
    
    
    
    var textColor: NSColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupClickGesture()
    }
    
    deinit {
        print("ViewController deinit")
    }
    
    func setupClickGesture() {
        //创建手势类
        let gr = NSClickGestureRecognizer(target: self, action: #selector(ViewController.magnify(_:)))
        //视图增加手势识别
        self.imageView.addGestureRecognizer(gr)
        gr.delegate = self
    }
    
    func openFilePanel() {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        openDlg.begin(completionHandler: { [weak self]  result in
            
            if(result.rawValue == NSFileHandlingPanelOKButton){
                let fileURLs = openDlg.urls
                for url:URL in fileURLs  {
                    let image = NSImage(contentsOf: url )
                    //更新imageView
                    self?.imageView.image = image
                    //存储选择的图像到image
                    self?.image = image
                }
            }
        })
    }
    
    
    func updateTextColor(_ color: NSColor) {
        
        if let target = self.undoManager?.prepare(withInvocationTarget: self) as? ViewController {
            target.updateTextColor(self.textColor!)
        }
        
        self.textColor = color
        self.textField.textColor = color
    }
    
    
}

extension ViewController:  NSGestureRecognizerDelegate {
    @objc func magnify(_ sender: NSClickGestureRecognizer) {
        self.openFilePanel()
    }
}

extension ViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            let text = textField.stringValue
            self.text = text
        }
    }
}


