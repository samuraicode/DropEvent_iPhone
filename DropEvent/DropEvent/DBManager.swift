//
//  DBManager.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import SugarRecordCoreData
import CoreData

class DBManager: NSObject {
    
    static let sharedInstance = DBManager()
    
    lazy var db: CoreDataDefaultStorage = {
        let store = CoreData.Store.Named("DropEvent")
        let bundle = NSBundle(forClass: DBManager.classForCoder())
        let model = CoreData.ObjectModel.Merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        return defaultStorage
    }()
}