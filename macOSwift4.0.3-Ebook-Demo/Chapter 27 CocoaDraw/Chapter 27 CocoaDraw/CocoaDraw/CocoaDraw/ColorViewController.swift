//
//  ColorViewController.swift
//  CocoaDraw
//
//  Created by iDevFans on 16/10/9.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ColorViewController: NSViewController {

     @IBOutlet var textView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func colorAction(_ sender: AnyObject) {
        
        let well = sender as! NSColorWell
        
        print("select color is \(well.color)")
    }
    
    @IBAction func changeColorButtonAction(_ sender: AnyObject) {
        
        let panel = NSColorPanel.shared()
        panel.setTarget(self)
        panel.setAction(#selector(self.colorSelect))
        panel.orderFront(self)
    }
    
    
    @IBAction func colorSelect(_ sender: AnyObject) {
        let panel = sender as! NSColorPanel
        self.textView.textColor = panel.color
        
        
        
    }
}
