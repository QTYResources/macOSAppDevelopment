//
//  Document.swift
//  PersonProfileDoc
//
//  Created by iDevFans on 16/8/6.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

class Document: NSDocument {
    @objc dynamic var profile: PersonProfile?
    override init() {
        super.init()
        profile = PersonProfile()
        //默认图片
        profile?.image = NSImage(named: NSImage.Name.user)
    }

    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        
        let document = windowController.document as! Document
        let viewController = windowController.contentViewController as! ViewController
        //viewController跟document之间profile属性数据绑定
        viewController.bind(NSBindingName(rawValue: "profile"), to: document, withKeyPath: "profile", options: nil)
    }

    override func data(ofType typeName: String) throws -> Data {
        return (self.profile?.docData())!
    }

    override func read(from data: Data, ofType typeName: String) throws {
        self.profile =  PersonProfile.profileFrom(data)
    }
    
    override func write(to url: URL, ofType typeName: String) throws {
        if typeName == "macdev.io.pdata" {
            return try! super.write(to: url, ofType: typeName)
        }
        if typeName == "macdev.io.pxdata" {
            let pdoc = PackageDocument()
            pdoc.setValue(self.profile, forKey: "profile")
            return try! pdoc.write(to: url, ofType: typeName)
        }
    }
}

