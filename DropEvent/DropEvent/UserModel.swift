//
//  UserModel.swift
//  DropEvent
//
//  Created by Jesse Gatt on 1/13/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import Foundation


class UserModel {
    
    var email: String
    var sessionToken: String
    
    static let sharedInstance = UserModel()
    
    convenience init() {
        //pull values out of db and keychain once that works
        self.init(email: "", sessionToken: "")
    }
    
    init(email: String, sessionToken: String) {
        self.email = email
        self.sessionToken = sessionToken
    }
    
    func save() {
        
    }
    
    
}