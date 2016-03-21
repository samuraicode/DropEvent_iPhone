//
//  EventFolderModel+CoreDataProperties.swift
//  DropEvent
//
//  Created by Jesse Gatt on 3/16/16.
//  Copyright © 2016 SamuraiCode. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension EventFolderModel {

    @NSManaged var allowUpload: NSNumber
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var photos: Set<EventPhotoModel>?
    @NSManaged var event: EventModel?

}
