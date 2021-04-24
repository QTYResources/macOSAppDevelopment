//
//  Document.swift
//  FileWrapper
//
//  Created by iDevFans on 16/8/5.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa

let  ImageFileName = "Image.png"
let  TextFileName  = "Text.txt"

class Document: NSDocument {

    @objc dynamic var image: NSImage?
    @objc dynamic var text: String?
    
    deinit {
        NSLog("Document deinit")
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        //建立双向绑定关系
        self.setupDataBindings(windowController)
        
        self.undoManager?.setActionName("Change Color")
    }
    
    func setupDataBindings(_ windowController: NSWindowController) {
        let document = windowController.document as! Document
        let viewController = windowController.contentViewController as! ViewController
        
        //document的image变化后更新viewController的image属性
        viewController.bind(NSBindingName(rawValue: "image"), to: document, withKeyPath: "image", options: nil)
        //viewController的image变化后更新document的image属性
        document.bind(NSBindingName(rawValue: "image"), to: viewController, withKeyPath: "image", options: nil)
        
        
        //document的text变化后更新viewController的text属性
        viewController.bind(NSBindingName(rawValue: "text"), to: document, withKeyPath: "text", options: nil)
        //viewController的text变化后更新document的text属性
        document.bind(NSBindingName(rawValue: "text"), to: viewController, withKeyPath: "text", options: nil)
    }
    
    override func fileWrapper(ofType typeName: String) throws -> FileWrapper {
        let  fileWrappers  = FileWrapper(directoryWithFileWrappers: [:])
        if self.image != nil {
            let imageRepresentations = self.image?.representations
            let imageData = NSBitmapImageRep.representationOfImageReps(in: imageRepresentations!, using: .png, properties: [:])

            let   imageFileWrapper = FileWrapper(regularFileWithContents: imageData!)
            imageFileWrapper.preferredFilename = ImageFileName
            fileWrappers.addFileWrapper(imageFileWrapper)
        }
        
        if self.text != nil {
            let textData = self.text?.data(using: String.Encoding.utf8)
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
            self.image = image
        }
        
        let textFileWrapper = fileWrappers?[TextFileName]
        
        if textFileWrapper != nil {
            let textData = textFileWrapper?.regularFileContents
            let textString = String(data: textData!, encoding: String.Encoding.utf8)
            self.text = textString;
        }
    }
}








