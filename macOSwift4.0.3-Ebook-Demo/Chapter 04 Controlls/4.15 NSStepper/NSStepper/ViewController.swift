//
//  ViewController.swift
//  NSStepper
//
//  Created by iDevFans on 16/6/30.
//  Copyright © 2016年 http://www.macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {


    @IBOutlet weak var pageSizeTextField: NSTextField!
   
    @IBOutlet weak var pageSizeStepper: NSStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func stepperAction(_ sender: NSStepper) {
        let theValue = sender.intValue
        self.pageSizeTextField.intValue = theValue
    }
    
    
    override func controlTextDidChange(_ obj: Notification) {
        let textField  = obj.object as! NSTextField
        self.pageSizeStepper.intValue = textField.intValue
    }
    
}





