//
//  UserDBModel+Fetch.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/27/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
import CoreStore

extension UserDBModel {
    
    static func fetchUser() -> UserDBModel? {
        return CoreStore.fetchOne(From(UserDBModel))
    }
    
}
