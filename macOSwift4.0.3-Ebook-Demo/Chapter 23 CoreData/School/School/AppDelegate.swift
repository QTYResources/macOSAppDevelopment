//
//  AppDelegate.swift
//  School
//
//  Created by zhaojw on 2017/12/9.
//  Copyright © 2017年 zhaojw. All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        addClassData()
        queryObject()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "School")
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
    
    func addClassData() {
        let classes = NSEntityDescription.insertNewObject(forEntityName: "Classes", into: managedObjectContext) as! Classes
        classes.title = "Class3";
        classes.studentsNum = 20;
        print("\(classes.objectID)")
        
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            NSApplication.shared.presentError(nserror)
        }
        print("\(classes.objectID)")
    }
    
    func deleteClassData() {
        
    }
    
    
    func queryObject() {
        
        
        let urlID = URL(string: "x-coredata://991E44CF-3DAD-4789-B70C-E78E1BF8D37E/Classes/p1")
        
        let objID = persistentStoreCoordinator.managedObjectID(forURIRepresentation: urlID!)
        //单个对象查询
        
        if let objID = objID {
            
            let object = managedObjectContext.object(with: objID)
            
            print("\(object.objectID)")
        }
        
        
        
        //查询对象
        let request = NSFetchRequest<Classes>(entityName: "Classes")
        //执行查询
        var results = try? managedObjectContext.fetch(request)
        
        for result: Classes in results! {
            print("\(result.objectID)")
        }
        
        
        let predicate = NSPredicate(format: "title = %@ ", "Class3") //查询title为Class3的班级
        request.predicate = predicate
        
        request.fetchOffset = 0
        request.fetchLimit = request.fetchOffset + 2
        
        //执行查询
        results = try? managedObjectContext.fetch(request)
        
        for result: Classes in results! {
            print("\(result.objectID)")
        }
        
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
    }

    

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

}

