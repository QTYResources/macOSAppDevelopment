//
//  ViewController.swift
//  NSTreeController
//
//  Created by iDevFans on 16/7/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var treeController: TreeController!
    
    @objc dynamic var treeNodes:[NSMutableDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       let rootNode = self.treeController.newObject() as! NSMutableDictionary 
       self.treeNodes.append(rootNode)
        
    }
}



