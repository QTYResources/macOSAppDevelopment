//
//  ViewController.swift
//  MDatabase
//
//  Created by iDevFans on 16/8/28.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
let dbName = "DatabaseDemo.sqlite"
class ViewController: NSViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        if MDatabase.shared.openDBWithName(dbName: dbName) {
            
            let personDAO = PersonDAO()
            
            var persons = personDAO.findAll()
            for person in persons! {
                let p = person as! Person
                print("person \(person)")
                print("address \(p.address)")
                print("name \(p.name)")
            }
            
            for person in persons! {
                let p = person as! Person
                p.name = "111"
                p.save()
            }
            
            persons = personDAO.findByAttributes(attributes: ["name":"to"])
            
            for person in persons! {
                let p = person as! Person
                print("name \(p.name)")
            }
            
            let person = personDAO.findBy(kv: ["id":13]) as! Person
            
            print("name \(person.name)")
            
            
            let codeGenerate = CodeGenerate()
            
            codeGenerate.makeCode()
            
        }
    }


}





