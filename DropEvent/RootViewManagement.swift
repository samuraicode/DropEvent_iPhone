//
//  RootViewManagement.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/22/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//

import UIKit

extension AppDelegate {
    func setEventsAsRoot() {
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("EventsNavCon")
    }
    
    func setLoginAsRoot() {
        self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginVC")
    }
}
