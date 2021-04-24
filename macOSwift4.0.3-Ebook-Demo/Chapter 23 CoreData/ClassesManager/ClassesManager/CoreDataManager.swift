//
//  CoreDataManager.swift
//  ClassesManager
//
//  Created by iDevFans on 16/8/14.
//  Copyright © 2016年 macdev. All rights reserved.
//

import Foundation
import Cocoa

class ClassesManager: NSObject  {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ClassesManager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator {
        return self.persistentContainer.persistentStoreCoordinator
    }
    
    // MARK: - Core Data Saving and Undo support
    
    @IBAction func saveAction(_ sender: AnyObject?) {
        
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }
    

    deinit {
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            print("\(nserror)")
        }
    }
    
}
