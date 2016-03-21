//
//  DBManager.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import CoreData
import CoreStore

class DBManager {
    
    static let sharedInstance = DBManager()
    
//    var userDataStack: DataStack
////    var eventsDataStack: DataStack
//    
//    init() {
//        CoreStore.defaultStack = DataStack(
//            modelName: "DropEventModel"
//        )
////        self.eventsDataStack = DataStack(
////            modelName: "Events"
////        )
//        do {
//            try CoreStore.defaultStack.addSQLiteStoreAndWait()
////            try self.eventsDataStack.addSQLiteStoreAndWait()
//        }catch {
//            
//        }
//    }
//    
    
    static func initStack() {
        CoreStore.defaultStack = DataStack(
            modelName: "DropEventModel"
        )
        do {
            try CoreStore.addSQLiteStoreAndWait()
        }catch {
            
        }
        
    }
//    lazy var db: CoreDataDefaultStorage = {
//        let store = CoreData.Store.Named("DropEvent")
//        let bundle = NSBundle(forClass: DBManager.classForCoder())
//        let model = CoreData.ObjectModel.Merged([bundle])
//        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
//        return defaultStorage
//    }()
}
