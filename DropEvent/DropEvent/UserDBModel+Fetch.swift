//
//  UserDBModel+Fetch.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
import SugarRecordCoreData

extension UserDBModel {
    
    static func fetchUser() -> UserDBModel? {
        let users = try! DBManager.sharedInstance.db.fetch(Request<UserDBModel>())
        if users.count == 0 {
            return nil
        }else {
            return users[0]
        }
    }
    
}
