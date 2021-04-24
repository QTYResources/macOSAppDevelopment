//
//  ViewController.swift
//  NSViewController
//
//  Created by iDevFans on 16/7/13.
//  Copyright © 2016年 http://macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    override func loadView() {

        
        print("loadView")
        super.loadView()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLoad() {
       
        print("viewDidLoad")
         super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewWillAppear() {
 
        
        print("viewWillAppear")
        super.viewWillAppear()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear() {
        
        
        print("viewDidAppear")
        super.viewDidAppear()
        // Do any additional setup after loading the view.
    }
    
    
    override func updateViewConstraints() {
        //let view = NSView()
       // view.updateConstraints();
        
        
        print("ViewController updateViewConstraints")
        super.updateViewConstraints()
        // Do any additional setup after loading the view.
    }
    
   
    
    override func viewWillLayout() {
        
        
        print("viewWillLayout")
        super.viewWillLayout()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayout() {
        
        
        print("viewDidLayout")
        super.viewDidLayout()
        // Do any additional setup after loading the view.
    }



    
    
    
}

