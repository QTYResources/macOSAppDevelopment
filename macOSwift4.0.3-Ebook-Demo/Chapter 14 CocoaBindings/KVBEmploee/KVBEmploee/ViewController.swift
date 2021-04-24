//
//  ViewController.swift
//  KVBEmploee
//
//  Created by iDevFans on 16/7/28.
//  Copyright © 2016年 macdev.io. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var objectController: NSObjectController!
    
    @IBOutlet weak var idTextFiled: NSTextField!
    @objc dynamic var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let em = Employee()
        em.id = 123213123
        em.name = "John"
        em.address = "China Beijing"
        em.age = 25
        
        self.employee = em
        

    }

    
    func bindTest(){
        
        objectController.bind(NSBindingName(rawValue: "content"), to: self, withKeyPath: "employee", options: nil)
        
        idTextFiled.bind(NSBindingName(rawValue: "value"), to: objectController, withKeyPath: "selection.id", options: nil)
        
        objectController.addObserver(idTextFiled, forKeyPath: "selection.id", options: .new, context: nil)
        
        employee?.addObserver(objectController, forKeyPath: "id", options: .new, context: nil)
        
        
        objectController.setValue(4, forKey: "selection.id")
        
        employee?.setValue(4, forKey: "id")
    }
    
    @IBAction func okAction(_ sender: NSButton) {
        print("id:\(employee?.id)")
        print("name:\(employee?.name)")
        print("address:\(employee?.address)")
        print("age:\(employee?.age)")
    }
    @IBAction func setIDAction(_ sender: Any) {
        
        employee?.name = "dgdfg"
        
        employee?.id = 10
    }
    
   
}



