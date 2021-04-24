//
//  ViewController.swift
//  ClassesManager
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {
    
    @IBOutlet var arrayController: NSArrayController!
    
    @IBOutlet weak var tableView: NSTableView!
    @objc dynamic lazy var classesManager: ClassesManager = {
        return ClassesManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try? self.arrayController.fetch(with: nil, merge: false)
    }
    
    override func viewDidAppear() {
        self.classesManager.managedObjectContext.undoManager = self.undoManager
    }
    
    @IBAction func addClassesAction(_ sender: NSButton){
        let classes = NSEntityDescription.insertNewObject(forEntityName: "Classes", into: self.classesManager.managedObjectContext) as! Classes
        classes.title = "unTitled";
        classes.studentsNum = 0;

    }
    
    @IBAction func deleteClassesAction(_ sender: NSButton){
        let selectedObjects:[Classes]  = self.arrayController.selectedObjects as! [Classes]
        for classObject: Classes  in selectedObjects {
            self.classesManager.managedObjectContext.delete(classObject)
        }
    }
    
    
    @IBAction func uploadPhotoAction(_ sender: NSButton){
        let index = self.tableView.selectedRow
        if index < 0 {
            return
        }
        self.openSelectClassPhotoFilePanel()
    }
    
    func openSelectClassPhotoFilePanel() {
        let openDlg = NSOpenPanel()
        openDlg.canChooseFiles = true
        openDlg.canChooseDirectories = false
        openDlg.allowsMultipleSelection = false
        openDlg.allowedFileTypes = ["png"]
        
        openDlg.begin(completionHandler: { [weak self]  result in
            if(result.rawValue == NSFileHandlingPanelOKButton){
                let fileURLs = openDlg.urls
                for url:URL in fileURLs  {
                    let image = NSImage(contentsOf: url as URL)
                    let imageRepresentations = image?.representations
                    let imageData = NSBitmapImageRep.representationOfImageReps(in: imageRepresentations!, using: .png, properties: [:])
                    let arrangedObjects = self?.arrayController.arrangedObjects as! [Classes]
                    let index = self?.tableView.selectedRow
                    let classObj = arrangedObjects[index!]
                    classObj.photo = imageData as NSData?;
                }
            }
        })
    }
    
    @IBAction func saveAction(_ sender: NSButton){
        self.classesManager.saveAction(sender)
    }
    
    
    @IBAction func queryClassesAction(_ sender: NSSearchField) {
        
        let content = sender.stringValue
        if content.characters.count <= 0 {
            return
        }
        
        let predicate: NSPredicate = NSPredicate(format:content)
        self.arrayController.filterPredicate = predicate
        
    }

    @IBAction func undo(_ sender: AnyObject){
        self.classesManager.managedObjectContext.undoManager?.undo()
    }
    
    @IBAction func redo(_ sender: AnyObject){
        self.classesManager.managedObjectContext.undoManager?.redo()
    }

}

