//
//  ViewController.swift
//  KVO
//
//  Created by iDevFans on 16/7/27.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    var teacher: Teacher?
    var student: Student?

    override func viewDidLoad() {
        super.viewDidLoad()

        teacher = Teacher()
        student = Student()
        
        student?.addObserver(teacher!, forKeyPath: "address", options:.new, context: nil)
    
        student?.address = "beijing"
    }
    
    deinit {
        student?.removeObserver(teacher!, forKeyPath: "address")
    }
    
}


