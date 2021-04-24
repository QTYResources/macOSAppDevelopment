//
//  NationTextViewController.swift
//  LocalizationTools
//
//  Created by iDevFans on 16/9/3.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class NationTextViewController: NSViewController {
    @IBOutlet var stringView: NSTextView!

    @IBOutlet weak var scrollView: NSScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.registerNotification()
    }
    
    
    func configView() {
        let bkColor = NSColor(hex:0x2c3135)
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = bkColor.cgColor
        
        self.stringView.font = NSFont(name: "Menlo", size: 12)
        self.stringView.textContainerInset = NSSize(width: 15, height: 10)
        
        let lineNumberView = NoodleLineNumberView(scrollView: self.scrollView)
        self.scrollView.verticalRulerView = lineNumberView
        
        self.scrollView.hasVerticalRuler = true
        self.scrollView.hasHorizontalRuler = false
        self.scrollView.rulersVisible = true
    }
    
    func registerNotification() {
         NotificationCenter.default.addObserver(self, selector:#selector(NationTextViewController.onFileChanged(_:)),  name:NSNotification.Name.onSelectedFile, object: nil)
    }
    
    @objc func onFileChanged(_ notification: Notification){
        let path = notification.object as? String
        guard let string = try?  String(contentsOfFile: path!)
            else {
                return
        }
        self.stringView.string = string
    }
}
