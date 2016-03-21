//
//  UserDBModel+CoreDataProperties.swift
//  DropEvent
//
//  Created by Jesse Gatt on 3/20/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension UserDBModel {

    @NSManaged var email: String?
    @NSManaged var sessionToken: String
    @NSManaged var myEvents: Set<EventModel>?
    @NSManaged var contributedEvents: Set<EventModel>?

}
