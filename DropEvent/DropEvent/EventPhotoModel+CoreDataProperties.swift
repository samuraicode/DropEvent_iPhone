//
//  EventPhotoModel+CoreDataProperties.swift
//  DropEvent
//
//  Created by Jesse Gatt on 2/29/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EventPhotoModel {

    @NSManaged var id: String
    @NSManaged var eventID: String
    @NSManaged var eventOwner: String
    @NSManaged var folderID: String
    @NSManaged var email: String
    @NSManaged var displayURLString: String
    @NSManaged var processedURLString: String
    @NSManaged var thumbNailURLString: String
    @NSManaged var taken: NSDate
    @NSManaged var uploaded: NSDate
    @NSManaged var caption: String
    @NSManaged var folder: NSManagedObject?

}
