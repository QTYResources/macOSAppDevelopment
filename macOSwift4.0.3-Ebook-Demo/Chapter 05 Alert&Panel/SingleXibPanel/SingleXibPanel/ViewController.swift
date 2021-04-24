//
//  ViewController.swift
//  SingleXibPanel
//
//  Created by iDevFans on 16/10/18.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let kCancelCode = 0
let kOkCode = 1

class ViewController: NSViewController {
    var topLevelArray: NSArray?
    lazy var myPanel: MyPanel? = {
        var panel: MyPanel?
        let nib  = NSNib.init(nibNamed: NSNib.Name(rawValue: "MyPanel"), bundle: Bundle.main)
        if let success =  nib?.instantiate(withOwner: self, topLevelObjects: &topLevelArray) {
            if success {
                for obj in self.topLevelArray! {
                    if obj is MyPanel {
                        panel = obj as? MyPanel
                        break
                    }
                }
            }
        }
        return panel
    }()
    
    @IBAction func showPanelAction(_ sender: AnyObject) {
        self.myPanel?.parent = self.view.window
        self.view.window?.beginSheet(self.myPanel!, completionHandler: {  returnCode in
            if returnCode.rawValue == kOkCode {
                print("returnCode \(returnCode)")

            }
        })
    }
}

