//
//  UserModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/13/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation
import CoreData


class UserModel {
    
    var email: String
    var sessionToken: String
    private var userDB: UserDBModel?
    private var userManagedObjectContext: NSManagedObjectContext
    private let entityName = "UserDBModel"
    
    static let sharedInstance = UserModel()
    
    convenience init() {
        //pull values out of db and keychain once that works
        self.init(email: "", sessionToken: "")
    }
    
    init(email: String, sessionToken: String) {
        self.userManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        self.userManagedObjectContext.parentContext = CoreDataStack.sharedInstance.mainObjectContext
        
        
        
        self.email = email
        self.sessionToken = sessionToken
    }
    
    func fetchDBModel() -> UserDBModel? {
//        let userFetch = NSFetchRequest(entityName: self.entityName)
//        
//        do {
//            self.userManagedObjectContext.performBlock({ [weak self] in
////                let fetchedUser = try self.userManagedObjectContext.executeRequest(userFetch)
//                
//            })
//        }catch {
//            //no entity exists in db yet
            return nil
//        }
    }
    
    func save() {
        
    }
    
    
}