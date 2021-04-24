//
//  PackageDocument.swift
//  PersonProfileDoc
//
//  Created by iDevFans on 16/8/8.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa
let  ImageFileName = "Image.png"
let  TextFileName  = "Text.txt"
class PackageDocument: NSDocument {
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
        
        let document = windowController.document as! PackageDocument
        let viewController = windowController.contentViewController as! ViewController
        //viewController跟document之间profile属性数据绑定
        viewController.bind(NSBindingName(rawValue: "profile"), to: document, withKeyPath: "profile", options: nil)
  
    }

    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        let  fileWrappers  = FileWrapper(directoryWithFileWrappers: [:])
        if self.profile?.image != nil {
            let imageRepresentations = self.profile?.image?.representations
            let imageData = NSBitmapImageRep.representationOfImageReps(in: imageRepresentations!, using: .png, properties: [:])
            
            let   imageFileWrapper = FileWrapper(regularFileWithContents: imageData!)
            imageFileWrapper.preferredFilename = ImageFileName
            fileWrappers.addFileWrapper(imageFileWrapper)
        }
        
        let textData = self.profile?.jsonData()
        if textData != nil {
            let textFileWrapper = FileWrapper(regularFileWithContents: textData!)
            textFileWrapper.preferredFilename = TextFileName
            fileWrappers.addFileWrapper(textFileWrapper)
        }
        return fileWrappers
    }
    
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        let fileWrappers = fileWrapper.fileWrappers
        let imageWrapper = fileWrappers?[ImageFileName]
        
        if imageWrapper != nil {
            let imageData = imageWrapper?.regularFileContents
            let image = NSImage(data: imageData!)
            self.profile?.image = image
        }
        
        let textFileWrapper = fileWrappers?[TextFileName]
        if textFileWrapper != nil {
            let textData = textFileWrapper?.regularFileContents
            self.profile?.updata(with: textData)
        }
    }
}
