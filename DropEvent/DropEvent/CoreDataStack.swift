//
//  CoreDataStack.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/19/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import CoreData


class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()
    
    let modelName = "DropEventModel"
    
    //MARK: Variables used to build the persistant store coordinator
    var applicationDocumentsDirectory: NSURL
    
    var managedObjectModel: NSManagedObjectModel
    
    var psc: NSPersistentStoreCoordinator
    
    var mainObjectContext: NSManagedObjectContext
    private var privateWriterContext: NSManagedObjectContext
//    = {
//        var managedObjectContext = NSManagedObjectContext(
//            concurrencyType: .MainQueueConcurrencyType)
//        managedObjectContext.persistentStoreCoordinator = self.psc
//        return managedObjectContext
//    }()
    
    
    init() {
        
        let urls = NSFileManager.defaultManager().URLsForDirectory(
            .DocumentDirectory, inDomains: .UserDomainMask)
        self.applicationDocumentsDirectory = urls[urls.count-1]
        
        let modelURL = NSBundle.mainBundle()
            .URLForResource(self.modelName,
                withExtension: "momd")!
        self.managedObjectModel = NSManagedObjectModel(contentsOfURL: modelURL)!
        
        
        self.psc = NSPersistentStoreCoordinator(
            managedObjectModel: self.managedObjectModel)
        let url =
        self.applicationDocumentsDirectory
            .URLByAppendingPathComponent("DropEventDatabase.sqlite")
        
        // 6
        do {
            try self.psc.addPersistentStoreWithType(
                NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            //7
            let nserror = error as NSError
            print("Error: \(nserror.localizedDescription)")
            abort()
        }
        
        self.privateWriterContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        self.privateWriterContext.persistentStoreCoordinator = self.psc
        
        self.mainObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        self.mainObjectContext.parentContext = self.privateWriterContext
        
    }
    
    func saveMainContext() {
        self.mainObjectContext.performBlock {[weak self] in
            do {
               try self!.mainObjectContext.save()
                self?.privateWriterContext.performBlock({ [weak self] in
                    do {
                       try self?.privateWriterContext.save()
                    }catch {
                        //handle errors with saving context
                    }
                })
            }catch {
                //handle errors with saving context
            }
            
        }
    }

    
    
    
}
